import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/data/datasources/auth/auth_datasource.dart';
import 'package:seva_auth/data/datasources/user/user_datasource.dart';
import 'package:seva_auth/data/models/user_model.dart';
import 'package:seva_auth/data/repositories/user_repository_impl.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/utils/failure.dart';

class AuthDatasourceMock extends Mock implements AuthDatasource {}

class UserDatasourceMock extends Mock implements UserDatasource {}

void main() {
  late final AuthDatasource authDatasource;
  late final UserDatasource userDatasource;
  late final UserRepository repository;
  late final UserModel userModel;
  setUpAll(() {
    authDatasource = AuthDatasourceMock();
    userDatasource = UserDatasourceMock();
    repository = UserRepositoryImpl(
      authDatasource,
      userDatasource,
    );
    userModel = const UserModel(
      id: 'id',
      name: 'name',
      email: 'email',
    );
  });
  group('[DATA] - UserRepository', () {
    group('registerUser', () {
      test('Should return the user', () async {
        // Arrange
        when(() => authDatasource.registerUser(
              name: 'name',
              email: 'email',
              password: 'password',
            )).thenAnswer((_) async => (userModel, null));
        when(() => userDatasource.saveUser(userModel))
            .thenAnswer((_) async => (null, null));

        // Act
        var (data, err) = await repository.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNotNull);
        expect(data, isA<UserModel>());
        expect(data, equals(userModel));
        expect(err, isNull);
      });
      test('Should return an error when register User', () async {
        // Arrange
        when(() => authDatasource.registerUser(
              name: 'name',
              email: 'email',
              password: 'password',
            )).thenAnswer((_) async => (null, Failure('error')));
        when(() => userDatasource.saveUser(userModel))
            .thenAnswer((_) async => (null, null));

        // Act
        var (data, err) = await repository.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('Failed to register user!'));
      });
      test('Should return an error when save User', () async {
        // Arrange
        when(() => authDatasource.registerUser(
              name: 'name',
              email: 'email',
              password: 'password',
            )).thenAnswer((_) async => (userModel, null));
        when(() => userDatasource.saveUser(userModel))
            .thenAnswer((_) async => (null, Failure('error')));

        // Act
        var (data, err) = await repository.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('Failed to save user!'));
      });
    });
    group('getStateAuth', () {
      test('Should return a Stream of user', () async {
        // Arrange
        when(() => authDatasource.getStateAuth())
            .thenAnswer((_) => Stream.value(userModel));

        // Act
        var stream = repository.getStateAuth();

        // Assert
        expect(stream, isNotNull);
        expect(stream, isA<Stream<UserModel?>>());
        expect(stream, emits(userModel));
      });
      test('Should return a Strem of null', () async {
        // Arrange
        when(() => authDatasource.getStateAuth())
            .thenAnswer((_) => Stream.value(null));

        // Act
        var stream = repository.getStateAuth();

        // Assert
        expect(stream, isNotNull);
        expect(stream, isA<Stream<UserModel?>>());
        expect(stream, emits(null));
      });
    });
    group('getCurrentUser', () {
      test('Should return the user', () {
        // Arrange
        when(() => authDatasource.getCurrentUser())
            .thenReturn((userModel, null));

        // Act
        var (data, err) = repository.getCurrentUser();

        // Assert
        expect(data, isNotNull);
        expect(data, isA<UserModel>());
        expect(data, equals(userModel));
        expect(err, isNull);
      });
      test('Should return an error', () async {
        // Arrange
        when(() => authDatasource.getCurrentUser())
            .thenReturn((null, Failure('User not found')));

        // Act
        var (data, err) = repository.getCurrentUser();

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('User not found'));
      });
    });
    group('signIn', () {
      test('Should make a login', () async {
        // Arrange
        when(() => authDatasource.signIn(
              email: 'email',
              password: 'password',
            )).thenAnswer((_) async => (true, null));

        // Act
        var (ok, err) = await repository.signIn(
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(ok, isNotNull);
        expect(ok, isA<bool>());
        expect(ok, equals(true));
        expect(err, isNull);
      });
      test('Should return an error', () async {
        // Arrange
        when(() => authDatasource.signIn(
              email: 'email',
              password: 'password',
            )).thenAnswer((_) async => (false, Failure('error')));

        // Act
        var (ok, err) = await repository.signIn(
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(ok, isNotNull);
        expect(ok, isA<bool>());
        expect(ok, equals(false));
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('error'));
      });
    });
    group('getUsers', () {
      test('Should return a list of users', () async {
        // Arrange
        when(() => userDatasource.getUsers())
            .thenAnswer((_) async => ([userModel], null));

        // Act
        var (data, err) = await repository.getUsers();

        // Assert
        expect(data, isNotNull);
        expect(data, isA<List<UserModel>>());
        expect(data, equals([userModel]));
        expect(err, isNull);
      });
      test('Should return an error', () async {
        // Arrange
        when(() => userDatasource.getUsers())
            .thenAnswer((_) async => (null, Failure('error')));

        // Act
        var (data, err) = await repository.getUsers();

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('error'));
      });
    });
    group('signOut', () {
      test('Should make a logout', () async {
        // Arrange
        when(() => authDatasource.signOut())
            .thenAnswer((_) async => (true, null));

        // Act
        var (ok, err) = await repository.signOut();

        // Assert
        expect(ok, isTrue);
        expect(err, isNull);
      });
      test('Should return an error', () async {
        // Arrange
        when(() => authDatasource.signOut())
            .thenAnswer((_) async => (false, Failure('error')));

        // Act
        var (ok, err) = await repository.signOut();

        // Assert
        expect(ok, isFalse);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('error'));
      });
    });
  });
}
