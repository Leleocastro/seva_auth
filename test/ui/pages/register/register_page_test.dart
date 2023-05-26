import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/ui/components/main_alert.dart';
import 'package:seva_auth/ui/components/main_button.dart';
import 'package:seva_auth/ui/pages/register/register_bloc.dart';
import 'package:seva_auth/ui/pages/register/register_page.dart';
import 'package:seva_auth/utils/base_state.dart';

class RegisterBlocMock extends Mock implements RegisterBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class RouteMock extends Mock implements Route {}

class MockBinding {
  static void init() {
    TestWidgetsFlutterBinding.ensureInitialized();

    GetIt.I.registerSingleton<RegisterBloc>(RegisterBlocMock());
  }
}

void main() {
  late RegisterBloc bloc;
  late UserEntity userEntity;
  late NavigatorObserver mockObserver;
  setUpAll(() {
    MockBinding.init();
    bloc = GetIt.I.get<RegisterBloc>();
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
    mockObserver = MockNavigatorObserver();
    registerFallbackValue(RouteMock());
  });
  group('[UI] - RegisterPage', () {
    testWidgets('LoadingState', (tester) async {
      when(() => bloc(
            name: any(named: 'name'),
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
          home: RegisterPage(),
        ),
      );

      await tester.pump();
      await tester.enterText(find.byKey(const Key('name')), "text");
      await tester.enterText(find.byKey(const Key('email')), "text");
      await tester.enterText(find.byKey(const Key('password')), "text");
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.byType(MainButton), warnIfMissed: false);
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('SuccessState', (tester) async {
      when(() => bloc(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => () {});
      whenListen(
        bloc,
        Stream<BaseState>.fromIterable([
          SuccessState(userEntity),
        ]),
        initialState: const LoadingState(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: const RegisterPage(),
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.pump();
      await tester.tap(find.byType(MainButton), warnIfMissed: false);
      await tester.pump();
      verify(() => mockObserver.didPop(any(), any()));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('ErrorState', (tester) async {
      await tester.runAsync(() async {
        when(() => bloc(
              name: any(named: 'name'),
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
            home: RegisterPage(),
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
