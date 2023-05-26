import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/usecases/sign_in.dart';
import 'package:seva_auth/domain/usecases/sign_out.dart';
import 'package:seva_auth/ui/pages/login/login_bloc.dart';
import 'package:seva_auth/utils/base_state.dart';
import 'package:seva_auth/utils/failure.dart';

class SignInMock extends Mock implements SignIn {}

class SignOutMock extends Mock implements SignOut {}

void main() {
  late SignIn signInUsecase;
  late SignOut signOutUsecase;
  late LoginBloc bloc;
  setUp(() {
    signInUsecase = SignInMock();
    signOutUsecase = SignOutMock();
    bloc = LoginBloc(signInUsecase, signOutUsecase);
  });

  group('[UI] - LoginBloc', () {
    group('login', () {
      blocTest<LoginBloc, BaseState>(
        'when return success',
        setUp: () {
          when(() => signInUsecase(
                email: 'email',
                password: 'password',
              )).thenAnswer((_) async => (true, null));
        },
        build: () => bloc,
        act: (bloc) => bloc.login(
          email: 'email',
          password: 'password',
        ),
        expect: () => [
          const LoadingState(),
          const SuccessState<bool?>(true),
        ],
      );
      blocTest<LoginBloc, BaseState>(
        'when return error',
        setUp: () {
          when(() => signInUsecase(
                email: 'email',
                password: 'password',
              )).thenAnswer((_) async => (null, Failure('error')));
        },
        build: () => bloc,
        act: (bloc) => bloc.login(
          email: 'email',
          password: 'password',
        ),
        expect: () => [
          const LoadingState(),
          const ErrorState('error'),
        ],
      );
    });
    group('logout', () {
      blocTest<LoginBloc, BaseState>(
        'when return success',
        setUp: () {
          when(() => signOutUsecase()).thenAnswer((_) async => (true, null));
        },
        build: () => bloc,
        act: (bloc) => bloc.logout(),
        expect: () => [
          const LoadingState(),
          const SuccessState<bool?>(true),
        ],
      );
      blocTest<LoginBloc, BaseState>(
        'when return error',
        setUp: () {
          when(() => signOutUsecase())
              .thenAnswer((_) async => (null, Failure('error')));
        },
        build: () => bloc,
        act: (bloc) => bloc.logout(),
        expect: () => [
          const LoadingState(),
          const ErrorState('error'),
        ],
      );
    });
  });
}
