import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seva_auth/ui/components/main_alert.dart';

void main() {
  group('[UI] - MainAlertNotification', () {
    testWidgets('Should show the alert', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () {
                MainAlertNotification.show(
                  tester.element(find.byType(ElevatedButton)),
                  title: 'Title',
                  message: 'Message',
                );
              },
              child: const Text('Show Alert'),
            ),
          ),
        ));

        await tester.pumpAndSettle();
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Message'), findsOneWidget);
      });
    });
    testWidgets('Should place MainAlertNotification in screen', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: MainAlertNotification(),
        ),
      ));

      expect(find.byType(MainAlertNotification), findsOneWidget);
    });
  });
}
