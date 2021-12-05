import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/data/format.dart';
import 'package:road_wave_fm_ui/models/format_model.dart';
import 'package:road_wave_fm_ui/widgets/format_checkbox.dart';

import '../utility.dart';

void main() {
  group((FormatCheckbox).toString(), () {
    testWidgets('throws error when FormatModel not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapWidget(const FormatCheckbox()));

      expect(tester.takeException(), isA<ProviderNotFoundException>());
    });

    testWidgets('construct when FormatModel provided',
        (WidgetTester tester) async {
      final model = FormatModel(const Format('testId', 'testName'), false);

      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: model, child: wrapWidget(const FormatCheckbox())));

      final checkbox = find.byType(Checkbox);
      expect(find.text('testName'), findsOneWidget);
      expect(checkbox, findsOneWidget);
      expect((checkbox.evaluate().single.widget as Checkbox).value, false);
    });

    testWidgets('toggles isSelected when tapped', (WidgetTester tester) async {
      final model = FormatModel(const Format('testId', 'testName'), true);
      await tester.pumpWidget(ChangeNotifierProvider.value(
          value: model, child: wrapWidget(const FormatCheckbox())));
      final checkbox = find.byType(Checkbox);

      await tester.tap(checkbox);
      await tester.pump();

      expect(model.isSelected, false);

      await tester.tap(checkbox);
      await tester.pump();

      expect(model.isSelected, true);
    });
  });
}
