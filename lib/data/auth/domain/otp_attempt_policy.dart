class OtpAttemptPolicy {
  OtpAttemptPolicy({this.maxAttempts = 3}) : assert(maxAttempts > 0);

  final int maxAttempts;
  int _attempts = 0;

  int get attempts => _attempts;

  bool get isLocked => _attempts >= maxAttempts;

  bool recordIncorrectAttempt() {
    if (isLocked) return true;

    _attempts++;
    return isLocked;
  }

  void reset() {
    _attempts = 0;
  }
}
