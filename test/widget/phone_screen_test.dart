// Keep and extend the existing phone_screen_test.dart from the project.
// The test pack does not overwrite your existing test because it already
// contains the project-specific navigation and localization setup.
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('phone screen test extension point is available', (tester) async {
    expect(tester, isNotNull);
  });
}
