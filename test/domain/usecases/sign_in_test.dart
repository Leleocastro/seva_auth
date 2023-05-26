import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/sign_in.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepoMock extends Mock implements UserRepository {}

void main() {
  late final UserRepository repository;
  late final SignIn usecase;
  setUpAll(() {
    repository = UserRepoMock();
    usecase = SignIn(repository);
  });

  group('[DOMAIN] - SignIn', () {
    test('Should make the login', () async {
      // Arrange
      when(() => repository.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (true, null));

      // Act
      var (data, err) = await usecase(
        email: 'email',
        password: 'password',
      );

      // Assert
      expect(data, isNotNull);
      expect(data, isA<bool>());
      expect(data, isTrue);
      expect(err, isNull);
    });
    test('Should return an error', () async {
      // Arrange
      when(() => repository.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        email: 'email',
        password: 'password',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('error'));
    });
  });
}
