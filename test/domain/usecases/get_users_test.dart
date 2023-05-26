import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/get_users.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepoMock extends Mock implements UserRepository {}

void main() {
  late final UserRepository repository;
  late final GetUsers usecase;
  late final UserEntity userEntity;
  setUpAll(() {
    repository = UserRepoMock();
    usecase = GetUsers(repository);
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });

  group('[DOMAIN] - GetUsers', () {
    test('Should return a list of users', () async {
      // Arrange
      when(() => repository.getUsers())
          .thenAnswer((_) async => ([userEntity], null));

      // Act
      var (data, err) = await usecase();

      // Assert
      expect(data, isNotNull);
      expect(data, isA<List<UserEntity>>());
      expect(data, equals([userEntity]));
      expect(err, isNull);
    });
    test('Should return an error when get list of users', () async {
      // Arrange
      when(() => repository.getUsers())
          .thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase();

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('error'));
    });
  });
}
