import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/register_user.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepoMock extends Mock implements UserRepository {}

void main() {
  late final UserRepository repository;
  late final RegisterUser usecase;
  late final UserEntity userEntity;
  setUpAll(() {
    repository = UserRepoMock();
    usecase = RegisterUser(repository);
    userEntity = const UserEntity(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });

  group('[DOMAIN] - RegisterUser', () {
    test('Should return register an user and return the user', () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (userEntity, null));

      // Act
      var (data, err) = await usecase(
        name: 'name',
        email: 'email@email.com',
        password: 'password',
      );

      // Assert
      expect(data, isNotNull);
      expect(data, isA<UserEntity>());
      expect(data, equals(userEntity));
      expect(err, isNull);
    });
    test('Should return an error when get list of users', () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        name: 'name',
        email: 'email@email.com',
        password: 'password',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('error'));
    });
    test('Should return failure because name is empty', () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        name: '',
        email: 'email@email.com',
        password: 'password',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('Name cannot be empty!'));
    });
    test('Should return failure because email is empty', () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        name: 'name',
        email: '',
        password: 'password',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('Invalid email!'));
    });
    test('Should return failure because email doesn\'t has @', () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        name: 'name',
        email: 'email',
        password: 'password',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message, equals('Invalid email!'));
    });
    test('Should return failure because password is empty', () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        name: 'name',
        email: 'email@email.com',
        password: '',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(err?.message,
          equals('Invalid password, must has more at least 6 characters!'));
    });
    test('Should return failure because password has less then 6 characters',
        () async {
      // Arrange
      when(() => repository.registerUser(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => (null, Failure('error')));

      // Act
      var (data, err) = await usecase(
        name: 'name',
        email: 'email@email.com',
        password: 'pass',
      );

      // Assert
      expect(data, isNull);
      expect(err, isA<Failure>());
      expect(
        err?.message,
        equals('Invalid password, must has more at least 6 characters!'),
      );
    });
  });
}
