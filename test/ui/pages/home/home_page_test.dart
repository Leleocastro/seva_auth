import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/ui/components/main_error_try_again.dart';
import 'package:seva_auth/ui/pages/home/home_bloc.dart';
import 'package:seva_auth/ui/pages/home/home_page.dart';
import 'package:seva_auth/ui/pages/login/login_bloc.dart';
import 'package:seva_auth/utils/base_state.dart';

class LoginBlocMock extends Mock implements LoginBloc {}

class HomeBlocMock extends Mock implements HomeBloc {}

class MockBinding {
  static void init() {
    TestWidgetsFlutterBinding.ensureInitialized();

    GetIt.I.registerSingleton<LoginBloc>(LoginBlocMock());
    GetIt.I.registerSingleton<HomeBloc>(HomeBlocMock());
  }
}

void main() {
  late HomeBloc homeMock;
  late UserEntity userEntity;
  setUpAll(() {
    MockBinding.init();
    homeMock = GetIt.I.get<HomeBloc>();
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });
  group('[UI] - HomePage', () {
    testWidgets('LoadingState', (tester) async {
      when(() => homeMock.getUsers()).thenAnswer((_) async => () {});
      whenListen(
        homeMock,
        Stream<BaseState>.fromIterable([
          const LoadingState(),
        ]),
        initialState: const LoadingState(),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('SuccessState', (tester) async {
      when(() => homeMock.getUsers()).thenAnswer((_) async => () {});
      whenListen(
        homeMock,
        Stream<BaseState>.fromIterable([
          SuccessState([userEntity, userEntity]),
        ]),
        initialState: const LoadingState(),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('ErrorState', (tester) async {
      when(() => homeMock.getUsers()).thenAnswer((_) async => () {});
      whenListen(
        homeMock,
        Stream<BaseState>.fromIterable([
          const ErrorState('Error'),
        ]),
        initialState: const LoadingState(),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(),
        ),
      );

      await tester.pump();
      expect(find.byType(MainErrorTryAgain), findsOneWidget);
    });
  });
}
