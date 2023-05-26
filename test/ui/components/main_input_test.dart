import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seva_auth/ui/components/main_input.dart';

void main() {
  group('[UI] - MainInput', () {
    testWidgets('Should show the input and type text', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MainInput(
            label: 'Label',
            hint: 'Hint',
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            isPassword: false,
            isRequired: false,
            validator: (value) {
              return null;
            },
            controller: controller,
          ),
        ),
      ));

      await tester.pump();
      await tester.enterText(find.byType(MainInput), "text");
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(MainInput), findsOneWidget);
      expect(controller.text, 'text');
    });
  });
}
