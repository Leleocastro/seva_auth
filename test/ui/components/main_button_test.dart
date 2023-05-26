import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seva_auth/ui/components/main_button.dart';

void main() {
  group('[UI] - MainButton', () {
    testWidgets('Should tap the button', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MainButton(
            label: 'Button',
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ));

      await tester.pumpAndSettle();
      await tester.tap(find.byType(MainButton));
      await tester.pumpAndSettle();

      expect(pressed, true);
      expect(find.text('Button'), findsOneWidget);
    });
  });
}
