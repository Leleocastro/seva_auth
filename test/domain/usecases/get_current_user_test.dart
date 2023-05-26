import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/get_current_user.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepoMock extends Mock implements UserRepository {}

void main() {
  late final UserRepository repository;
  late final GetCurrentUser usecase;
  late final UserEntity userEntity;
  setUpAll(() {
    repository = UserRepoMock();
    usecase = GetCurrentUser(repository);
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });

  group('[DOMAIN] - GetCurrentUser', () {
    test('Should return a user', () {
      // Arrange
      when(() => repository.getCurrentUser())
          .thenAnswer((_) => (userEntity, null));

      // Act
      var (data, err) = usecase();

      // Assert
      expect(data, isNotNull);
      expect(data, isA<UserEntity>());
      expect(data, equals(userEntity));
      expect(err, isNull);
    });
    test('Should return an error when get current user', () {
      // Arrange
      when(() => repository.getCurrentUser())
          .thenAnswer((_) => (null, Failure('error')));

      // Act
      var (data, err) = usecase();

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('error'));
    });
  });
}
