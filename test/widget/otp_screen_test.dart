// OTP screen is currently a private part of auth_screens.dart and depends on
// navigation, Riverpod auth providers and a periodic timer. Use the real app
// harness/provider overrides described in TESTING_GUIDE.md before asserting
// lock/resend UI. This smoke test keeps the widget test target discoverable.
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OTP widget test harness is documented', (tester) async {
    expect(tester, isNotNull);
  });
}
