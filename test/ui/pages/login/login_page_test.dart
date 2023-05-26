import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/ui/components/main_alert.dart';
import 'package:seva_auth/ui/components/main_button.dart';
import 'package:seva_auth/ui/pages/login/login_bloc.dart';
import 'package:seva_auth/ui/pages/login/login_page.dart';
import 'package:seva_auth/utils/base_state.dart';

class LoginBlocMock extends Mock implements LoginBloc {}

class MockBinding {
  static void init() {
    TestWidgetsFlutterBinding.ensureInitialized();

    GetIt.I.registerSingleton<LoginBloc>(LoginBlocMock());
  }
}

void main() {
  late LoginBloc bloc;
  setUpAll(() {
    MockBinding.init();
    bloc = GetIt.I.get<LoginBloc>();
  });
  group('[UI] - LoginPage', () {
    testWidgets('LoadingState', (tester) async {
      when(() => bloc.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => () {});
      whenListen(
        bloc,
        Stream<BaseState>.fromIterable([
          const LoadingState(),
        ]),
        initialState: const LoadingState(),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      await tester.pump();
      await tester.enterText(find.byKey(const Key('email')), "text");
      await tester.enterText(find.byKey(const Key('password')), "text");
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.byType(MainButton));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('SuccessState', (tester) async {
      when(() => bloc.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => () {});
      whenListen(
        bloc,
        Stream<BaseState>.fromIterable([
          const SuccessState(true),
        ]),
        initialState: const LoadingState(),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(MainButton));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('ErrorState', (tester) async {
      await tester.runAsync(() async {
        when(() => bloc.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => () {});
        whenListen(
          bloc,
          Stream<BaseState>.fromIterable([
            const ErrorState('Error'),
          ]),
          initialState: const LoadingState(),
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: LoginPage(),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.byType(MainButton), warnIfMissed: false);
        await tester.pumpAndSettle();
        expect(find.text('Error'), findsNWidgets(2));
        expect(find.byType(MainAlertNotification), findsOneWidget);
      });
    });
  });
}
