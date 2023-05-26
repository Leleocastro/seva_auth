import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/usecases/get_users.dart';
import 'package:seva_auth/ui/pages/home/home_bloc.dart';
import 'package:seva_auth/utils/base_state.dart';
import 'package:seva_auth/utils/failure.dart';

class GetUsersMock extends Mock implements GetUsers {}

void main() {
  late GetUsers usecase;
  late HomeBloc bloc;
  late UserEntity userEntity;
  setUp(() {
    usecase = GetUsersMock();
    bloc = HomeBloc(usecase);
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });

  group('[UI] - HomeBloc', () {
    blocTest<HomeBloc, BaseState>(
      'when return success',
      setUp: () {
        when(() => usecase()).thenAnswer((_) async => ([userEntity], null));
      },
      build: () => bloc,
      act: (bloc) => bloc.getUsers(),
      expect: () => [
        const LoadingState(),
        SuccessState<List<UserEntity>?>([userEntity]),
      ],
    );
    blocTest<HomeBloc, BaseState>(
      'when return error',
      setUp: () {
        when(() => usecase()).thenAnswer((_) async => (null, Failure('error')));
      },
      build: () => bloc,
      act: (bloc) => bloc.getUsers(),
      expect: () => [
        const LoadingState(),
        const ErrorState('error'),
      ],
    );
  });
}
