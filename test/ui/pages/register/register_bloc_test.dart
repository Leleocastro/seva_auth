import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/usecases/register_user.dart';
import 'package:seva_auth/ui/pages/register/register_bloc.dart';
import 'package:seva_auth/utils/base_state.dart';
import 'package:seva_auth/utils/failure.dart';

class RegisterUserMock extends Mock implements RegisterUser {}

void main() {
  late RegisterUser usecase;
  late RegisterBloc bloc;
  late UserEntity userEntity;
  setUp(() {
    usecase = RegisterUserMock();
    bloc = RegisterBloc(usecase);
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });

  group('[UI] - RegisterBloc', () {
    blocTest<RegisterBloc, BaseState>(
      'when return success',
      setUp: () {
        when(() => usecase(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => (userEntity, null));
      },
      build: () => bloc,
      act: (bloc) => bloc(
        name: 'name',
        email: 'email',
        password: 'password',
      ),
      expect: () => [
        const LoadingState(),
        SuccessState<UserEntity?>(userEntity),
      ],
    );
    blocTest<RegisterBloc, BaseState>(
      'when return error',
      setUp: () {
        when(() => usecase(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => (null, Failure('error')));
      },
      build: () => bloc,
      act: (bloc) => bloc(
        name: 'name',
        email: 'email',
        password: 'password',
      ),
      expect: () => [
        const LoadingState(),
        const ErrorState('error'),
      ],
    );
  });
}
