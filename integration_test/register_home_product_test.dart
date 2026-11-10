import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jd_donuts/core/storage/local_database.dart';
import 'package:jd_donuts/core/storage/session_storage.dart';
import 'package:jd_donuts/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('new member can register, open Home and view a product',
      (tester) async {
    await LocalDatabase.initialize();
    await SessionStorage.clear();
    await tester.pumpWidget(const ProviderScope(child: JDonutsApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text("LET'S GET STARTED"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '09254135592');
    await tester.pump();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '123456');
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Hnin Ei');
    await tester.pump();
    await tester.tap(find.text('CONTINUE'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'May');
    await tester.enterText(fields.at(1), '1');
    await tester.enterText(fields.at(2), '2000');
    await tester.pump();
    await tester.tap(find.text('CONTINUE'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.text("LET'S EXPLORE"));
    await tester.pumpAndSettle();
    expect(find.text('Seasonal specials'), findsOneWidget);

    await tester.tap(find.text('Coconut Donut').first);
    await tester.pumpAndSettle();
    expect(find.text('3,200 MMK'), findsOneWidget);
    expect(find.textContaining('ADD TO CART'), findsOneWidget);
  });
}
