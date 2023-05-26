import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/sign_out.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepoMock extends Mock implements UserRepository {}

void main() {
  late final UserRepository repository;
  late final SignOut usecase;
  setUpAll(() {
    repository = UserRepoMock();
    usecase = SignOut(repository);
  });

  group('[DOMAIN] - SignOut', () {
    test('Should make the logout', () async {
      // Arrange
      when(() => repository.signOut()).thenAnswer((_) async => (true, null));

      // Act
      var (data, err) = await usecase();

      // Assert
      expect(data, isNotNull);
      expect(data, isA<bool>());
      expect(data, isTrue);
      expect(err, isNull);
    });
    test('Should return an error', () async {
      // Arrange
      when(() => repository.signOut())
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
