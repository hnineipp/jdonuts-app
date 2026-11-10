part of '../auth_screens.dart';

class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key, required this.isLogin});
  final bool isLogin;
  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _touched = false;
  bool get _valid => AuthValidators.isValidPhone(_controller.text);
  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus) setState(() => _touched = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _AuthShell(
      progress: .25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.enterPhoneNumber,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '+95',
                  style: TextStyle(color: AppColors.muted),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focus,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 -]')),
                  ],
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l10n.phoneNumber,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: AppColors.secondary,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_touched && !_valid)
            AnimatedSize(
              duration: AppMotion.duration(context, AppMotion.fast),
              curve: AppMotion.standard,
              child: _touched && !_valid
                  ? Padding(
                      padding: EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        l10n.invalidMyanmarPhone,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          const Spacer(),
          PrimaryButton(
            label: l10n.continueLabel,
            enabled: _valid,
            onPressed: () {
              ref.registrationVM.setPhone(
                AuthValidators.normalizeMyanmarPhone(_controller.text),
                login: widget.isLogin,
              );

              context.pushNamed(
                RouteNames.main.otp,
                queryParameters: {
                  'phone': AuthValidators.normalizeMyanmarPhone(
                    _controller.text,
                  ),
                  'mode': widget.isLogin ? 'login' : 'register',
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
