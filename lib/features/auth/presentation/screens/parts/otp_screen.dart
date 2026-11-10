part of '../auth_screens.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.phone, required this.isLogin});

  final String phone;
  final bool isLogin;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen>
    with SingleTickerProviderStateMixin {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());

  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  Timer? _timer;

  int _seconds = 300;
  int _attempts = 0;
  bool _locked = false;
  bool _loading = false;
  String? _error;

  String get _code => _controllers.map((controller) => controller.text).join();

  @override
  void initState() {
    super.initState();
    _initializeShakeAnimation();
    _startTimer();
  }

  void _initializeShakeAnimation() {
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -4), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -4, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_seconds <= 1) {
        timer.cancel();
        setState(() => _seconds = 0);
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeController.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(int index, String value) {
    if (value.length > 1) {
      _fillCodeFromPaste(value);
    } else if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() => _error = null);
    if (_code.length == 6) _verifyCode();
  }

  void _fillCodeFromPaste(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    final code = digits.length > 6 ? digits.substring(0, 6) : digits;

    for (var index = 0; index < 6; index++) {
      _controllers[index].text = index < code.length ? code[index] : '';
    }

    final nextIndex = code.length.clamp(0, 5);
    _focusNodes[nextIndex].requestFocus();

    setState(() => _error = null);

    if (code.length == 6) {
      _verifyCode();
    }
  }

  Future<void> _verifyCode() async {
    if (_loading || _locked || _code.length != 6) return;
    if (!AuthValidators.isValidOtp(_code)) {
      _handleInvalidCode();
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (widget.isLogin) {
      await _completeLogin();
    } else {
      setState(() => _loading = false);
      context.push('/name');
    }
  }

  void _handleInvalidCode() {
    setState(() {
      _attempts++;
      _locked = _attempts >= 3;
      _error = _locked
          ? AppLocalizations.of(context).tooManyIncorrectOtpAttempts
          : AppLocalizations.of(context).incorrectOtp;
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _shakeController.forward(from: 0);
    if (!_locked) _focusNodes.first.requestFocus();
  }

  Future<void> _completeLogin() async {
    try {
      final exists = await ref.authVM.verifyLogin(widget.phone);
      if (!mounted) return;
      if (exists) {
        context.go('/home');
      } else {
        setState(() {
          _loading = false;
          _error = AppLocalizations.of(context).unregisteredPhone;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).unableToSignIn;
      });
    }
  }

  void _resendCode() {
    setState(() {
      _locked = false;
      _attempts = 0;
      _error = null;
      for (final controller in _controllers) {
        controller.clear();
      }
    });
    _focusNodes.first.requestFocus();
    _startTimer();
  }

  void _openRegistration() {
    ref.registrationVM.setPhone(widget.phone, login: false);
    context.push('/name');
  }

  @override
  Widget build(BuildContext context) {
    return _AuthShell(
      progress: .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeading(context),
          SizedBox(height: 28.h),
          _buildCodeFields(),
          if (_error != null) _buildError(),
          SizedBox(height: 24.h),
          Text(
            _locked
                ? AppLocalizations.of(context).tooManyAttemptsResend
                : AppLocalizations.of(context).didntReceiveCode,
            style: const TextStyle(fontSize: 14, color: AppColors.muted),
          ),
          SizedBox(height: 6.h),
          OtpResendButton(seconds: _seconds, onResend: _resendCode),
          const Spacer(),
          if (_loading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
        ],
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).verifyYourNumber,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context).otpSentTo(widget.phone),
          style: const TextStyle(fontSize: 14, color: AppColors.muted),
        ),
      ],
    );
  }

  Widget _buildCodeFields() {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) => Transform.translate(
        offset: Offset(_shakeAnimation.value, 0),
        child: child,
      ),
      child: OtpCodeFields(
        controllers: _controllers,
        focusNodes: _focusNodes,
        enabled: !_locked,
        onChanged: _onCodeChanged,
      ),
    );
  }

  Widget _buildError() {
    final isUnregistered = widget.isLogin &&
        _error == AppLocalizations.of(context).unregisteredPhone;
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: isUnregistered
          ? OtpRegistrationError(onRegister: _openRegistration)
          : Text(
              _error!,
              style: TextStyle(
                color: AppColors.error,
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),
    );
  }
}
