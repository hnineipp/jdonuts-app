part of '../auth_screens.dart';

class BirthDateScreen extends ConsumerStatefulWidget {
  const BirthDateScreen({super.key});
  @override
  ConsumerState<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends ConsumerState<BirthDateScreen> {
  final _month = TextEditingController();
  final _day = TextEditingController();
  final _year = TextEditingController();
  bool _invalid = false;
  bool _loading = false;
  String? _submitError;

  bool get _hasFullDate =>
      _month.text.trim().isNotEmpty &&
      _day.text.trim().isNotEmpty &&
      _year.text.length == 4;

  @override
  void initState() {
    super.initState();

    final saved = ref.read(registrationControllerProvider);

    _month.text = saved.birthMonth;
    _day.text = saved.birthDay;
    _year.text = saved.birthYear;
  }

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  bool get _isValidBirthDate {
    final monthText = _month.text.trim();

    final month = int.tryParse(monthText) ??
        _monthNames.indexWhere(
              (m) => m.toLowerCase() == monthText.toLowerCase(),
            ) +
            1;

    final day = int.tryParse(_day.text.trim());
    final year = int.tryParse(_year.text.trim());

    if (month < 1 ||
        month > 12 ||
        day == null ||
        year == null ||
        _year.text.trim().length != 4) {
      return false;
    }

    return BirthDateValidator.isValid(
      year: year,
      month: month,
      day: day,
      today: DateTime.now(),
    );
  }

  String? get _birthDateError {
    if (!_hasFullDate || _isValidBirthDate) return null;

    final monthText = _month.text.trim();

    final month = int.tryParse(monthText) ??
        _monthNames.indexWhere(
              (m) => m.toLowerCase() == monthText.toLowerCase(),
            ) +
            1;

    final day = int.tryParse(_day.text.trim());
    final year = int.tryParse(_year.text.trim());

    if (month < 1 ||
        month > 12 ||
        day == null ||
        year == null ||
        _year.text.trim().length != 4) {
      return AppLocalizations.of(context).invalidDateOfBirth;
    }

    final date = DateTime(year, month, day);

    if (date.year != year || date.month != month || date.day != day) {
      return AppLocalizations.of(context).invalidCalendarDate;
    }

    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);

    if (date.isAfter(currentDate)) {
      return AppLocalizations.of(context).futureDateOfBirth;
    }

    return AppLocalizations.of(context).minimumAgeError;
  }

  @override
  void dispose() {
    _month.dispose();
    _day.dispose();
    _year.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _AuthShell(
      progress: 1,
      complete: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whatsYourDateOfBirth,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 22.h),
          TextField(
            controller: _month,
            textCapitalization: TextCapitalization.words,
            onChanged: (_) {
              ref.registrationVM.setBirthDateDraft(
                month: _month.text,
                day: _day.text,
                year: _year.text,
              );

              setState(() {
                _invalid = _hasFullDate && !_isValidBirthDate;
              });
            },
            decoration: InputDecoration(hintText: l10n.month),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _day,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onChanged: (_) {
              ref.registrationVM.setBirthDateDraft(
                month: _month.text,
                day: _day.text,
                year: _year.text,
              );

              setState(() {
                _invalid = _hasFullDate && !_isValidBirthDate;
              });
            },
            decoration: InputDecoration(hintText: l10n.day),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _year,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            onChanged: (_) {
              ref.registrationVM.setBirthDateDraft(
                month: _month.text,
                day: _day.text,
                year: _year.text,
              );

              setState(() {
                _invalid = _hasFullDate && !_isValidBirthDate;
              });
            },
            decoration: InputDecoration(hintText: l10n.year),
          ),
          if (_invalid && _birthDateError != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                _birthDateError!,
                style: const TextStyle(color: AppColors.error, fontSize: 13),
              ),
            ),
          if (_submitError != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                _submitError!,
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 13,
                ),
              ),
            ),
          const Spacer(),
          PrimaryButton(
            label: l10n.continueLabel,
            enabled: _isValidBirthDate && !_loading,
            loading: _loading,
            onPressed: () async {
              if (!_isValidBirthDate) {
                setState(() => _invalid = true);
                return;
              }

              final monthText = _month.text.trim();

              final month = int.tryParse(monthText) ??
                  _monthNames.indexWhere(
                        (m) => m.toLowerCase() == monthText.toLowerCase(),
                      ) +
                      1;

              final date = DateTime(
                int.parse(_year.text.trim()),
                month,
                int.parse(_day.text.trim()),
              );

              final data = ref.read(registrationControllerProvider);

              setState(() {
                _loading = true;
                _submitError = null;
              });

              try {
                await ref.authVM.register(
                  phone: data.phone,
                  firstName: data.firstName,
                  lastName: data.lastName,
                  dateOfBirth: date,
                );

                if (context.mounted) {
                  context.goNamed(RouteNames.main.welcome);
                }
              } catch (error) {
                if (mounted) {
                  setState(() {
                    _submitError =
                        AppLocalizations.of(context).registrationFailed;
                  });
                }
              } finally {
                if (mounted) {
                  setState(() => _loading = false);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
