import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/get_state_auth.dart';

class UserRepoMock extends Mock implements UserRepository {}

void main() {
  late final UserRepository repository;
  late final GetStateAuth usecase;
  late final UserEntity userEntity;
  setUpAll(() {
    repository = UserRepoMock();
    usecase = GetStateAuth(repository);
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });

  group('[DOMAIN] - GetStateAuth', () {
    test('Should return a Stream of user', () {
      // Arrange
      when(() => repository.getStateAuth())
          .thenAnswer((_) => Stream.value(userEntity));

      // Act
      var stream = usecase();

      // Assert
      expect(stream, isNotNull);
      expect(stream, isA<Stream<UserEntity?>>());
      expect(stream, emits(userEntity));
    });
    test('Should return a Stream with null', () {
      // Arrange
      when(() => repository.getStateAuth())
          .thenAnswer((_) => Stream.value(null));

      // Act
      var stream = usecase();

      // Assert
      expect(stream, isNotNull);
      expect(stream, isA<Stream<UserEntity?>>());
      expect(stream, emits(null));
    });
  });
}
