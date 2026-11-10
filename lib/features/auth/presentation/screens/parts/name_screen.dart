part of '../auth_screens.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});
  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _firstFocus = FocusNode();
  final _lastFocus = FocusNode();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();

    final saved = ref.read(registrationControllerProvider);

    _first.text = saved.firstName;
    _last.text = saved.lastName;

    _firstFocus.addListener(() {
      if (!_firstFocus.hasFocus) {
        setState(() => _submitted = true);
      }
    });

    _lastFocus.addListener(() {
      if (!_lastFocus.hasFocus) {
        setState(() => _submitted = true);
      }
    });
  }

  bool get _valid =>
      AuthValidators.isValidName(_first.text) &&
      AuthValidators.isValidName(_last.text, required: false);
  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _firstFocus.dispose();
    _lastFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _AuthShell(
      progress: .75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whatsYourName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 22.h),
          TextField(
            controller: _first,
            focusNode: _firstFocus,
            textCapitalization: TextCapitalization.words,
            onChanged: (_) {
              ref.registrationVM.setName(
                _first.text,
                _last.text,
              );
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: l10n.firstName,
              errorText: _submitted && !AuthValidators.isValidName(_first.text)
                  ? l10n.invalidFirstName
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _last,
            focusNode: _lastFocus,
            textCapitalization: TextCapitalization.words,
            onChanged: (_) {
              ref.registrationVM.setName(
                _first.text,
                _last.text,
              );
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: l10n.lastName,
              errorText: _submitted &&
                      !AuthValidators.isValidName(
                        _last.text,
                        required: false,
                      )
                  ? l10n.invalidNameCharacters
                  : null,
            ),
          ),
          const Spacer(),
          PrimaryButton(
            label: l10n.continueLabel,
            enabled: _valid,
            onPressed: () {
              setState(() => _submitted = true);
              if (_valid) {
                ref.registrationVM
                    .setName(_first.text.trim(), _last.text.trim());
                context.pushNamed(RouteNames.main.birthDate);
              }
            },
          ),
        ],
      ),
    );
  }
}
