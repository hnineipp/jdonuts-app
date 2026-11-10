class BirthDateValidator {
  BirthDateValidator._();

  static const int minimumAge = 13;

  static bool isValid({
    required int year,
    required int month,
    required int day,
    required DateTime today,
  }) {
    if (year < 1 || month < 1 || month > 12 || day < 1 || day > 31) {
      return false;
    }

    final date = DateTime(year, month, day);

    // Reject invalid calendar dates.
    if (date.year != year || date.month != month || date.day != day) {
      return false;
    }

    // Reject future dates.
    final currentDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    if (date.isAfter(currentDate)) return false;

    // Calculate actual age.
    var age = today.year - year;

    final birthdayNotReached =
        today.month < month || (today.month == month && today.day < day);

    if (birthdayNotReached) age--;

    return age >= minimumAge;
  }
}
