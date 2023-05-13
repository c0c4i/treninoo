import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:treninoo/main.dart' as app;
import 'package:treninoo/view/components/buttons/action_button.dart';
import 'package:treninoo/view/components/textfield.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  checkTrainStatusPage() {
    expect(find.textContaining('Stazione'), findsOneWidget);
    expect(find.textContaining('Bin.'), findsOneWidget);
    expect(find.textContaining('Arrivo'), findsOneWidget);
    expect(find.textContaining('Partenza'), findsOneWidget);
  }

  group('Search train by code', () {
    testWidgets('Search train that doesn\'t exist',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      const trainCode = '312321321';
      final textFieldFinder =
          find.widgetWithText(BeautifulTextField, 'Codice treno');
      await tester.enterText(textFieldFinder, trainCode);
      final searchButtonFinder = find.widgetWithText(ActionButton, 'Cerca');
      await tester.tap(searchButtonFinder);
      await tester.pump(Duration(seconds: 2));
      final errorLabelFinder = find.text('Treno non trovato');
      expect(errorLabelFinder, findsOneWidget);
    });

    testWidgets('Search unique train', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      const trainCode = '8527';
      final textFieldFinder =
          find.widgetWithText(BeautifulTextField, 'Codice treno');
      await tester.enterText(textFieldFinder, trainCode);
      final searchButtonFinder = find.widgetWithText(ActionButton, 'Cerca');
      await tester.tap(searchButtonFinder);
      await tester.pumpAndSettle();
      checkTrainStatusPage();
    });

    testWidgets('Search train that share same code',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      const trainCode = '35';
      final textFieldFinder =
          find.widgetWithText(BeautifulTextField, 'Codice treno');
      await tester.enterText(textFieldFinder, trainCode);
      final searchButtonFinder = find.widgetWithText(ActionButton, 'Cerca');
      await tester.tap(searchButtonFinder);
      await tester.pumpAndSettle();
      final departureStationDialogFinder =
          find.widgetWithText(ListTile, 'DOMODOSSOLA');
      await tester.tap(departureStationDialogFinder);
      await tester.pumpAndSettle();
      checkTrainStatusPage();
    });
  });
}
