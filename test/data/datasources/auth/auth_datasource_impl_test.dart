import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/data/datasources/auth/auth_datasource_impl.dart';
import 'package:seva_auth/data/models/user_model.dart';
import 'package:seva_auth/utils/failure.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserMock extends Mock implements User {}

class UserCredentialMock implements UserCredential {
  final User? userMock;
  UserCredentialMock({required this.userMock});
  @override
  AdditionalUserInfo? get additionalUserInfo => throw UnimplementedError();

  @override
  AuthCredential? get credential => throw UnimplementedError();

  @override
  User? get user => userMock;
}

void main() {
  late final FirebaseAuth firebase;
  late final AuthDatasourceImpl datasource;
  late final User user;
  late UserCredential userCredential;
  setUpAll(() {
    firebase = FirebaseAuthMock();
    datasource = AuthDatasourceImpl(firebase);
    user = UserMock();
  });

  setUp(() {
    userCredential = UserCredentialMock(userMock: user);
  });
  group('[DATA] - AuthDatasource', () {
    group('registerUser', () {
      test('Should return the user', () async {
        // Arrange
        when(() => firebase.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => userCredential);
        when(() => userCredential.user!.uid).thenReturn('uid');
        when(() => userCredential.user!.updateDisplayName(any()))
            .thenAnswer((_) async {});

        // Act
        var (data, err) = await datasource.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNotNull);
        expect(data, isA<UserModel>());
        expect(data?.id, equals('uid'));
        expect(data?.name, equals('name'));
        expect(data?.email, equals('email'));
        expect(err, isNull);
      });
      test('Should return failure when user is null', () async {
        // Arrange
        userCredential = UserCredentialMock(userMock: null);
        when(() => firebase.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => userCredential);

        // Act
        var (data, err) = await datasource.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('User not created'));
      });
      test('Should return failure when FirebaseAuthException', () async {
        // Arrange
        when(() => firebase.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(FirebaseAuthException(code: 'code', message: 'msg'));

        // Act
        var (data, err) = await datasource.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('msg'));
      });
      test('Should return failure when occurs some Exception', () async {
        // Arrange
        when(() => firebase.createUserWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('msg'));

        // Act
        var (data, err) = await datasource.registerUser(
          name: 'name',
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('Exception: msg'));
      });
    });
    group('getStateAuth', () {
      test('Should return a Stream of user', () async {
        // Arrange
        when(() => firebase.authStateChanges())
            .thenAnswer((_) => Stream.value(user));

        // Act
        var stream = datasource.getStateAuth();

        // Assert
        expect(stream, isNotNull);
        expect(stream, isA<Stream<UserModel?>>());
      });
      test('Should return failure when user is null', () async {
        // Arrange
        when(() => firebase.authStateChanges())
            .thenAnswer((_) => Stream.value(null));

        // Act
        var stream = datasource.getStateAuth();

        // Assert
        expect(stream, isNotNull);
        expect(stream, isA<Stream<UserModel?>>());
        expect(stream, emits(null));
      });
    });
    group('getCurrentUser', () {
      test('Should return the user', () async {
        // Arrange
        when(() => firebase.currentUser).thenReturn(user);
        when(() => user.uid).thenReturn('uid');
        when(() => user.displayName).thenReturn('name');
        when(() => user.email).thenReturn('email');

        // Act
        var (data, err) = datasource.getCurrentUser();

        // Assert
        expect(data, isNotNull);
        expect(data, isA<UserModel>());
        expect(data?.id, equals(user.uid));
        expect(data?.name, equals(user.displayName));
        expect(data?.email, equals(user.email));
        expect(err, isNull);
      });
      test('Should return null when user is null and Failure', () async {
        // Arrange
        when(() => firebase.currentUser).thenReturn(null);

        // Act
        var (data, err) = datasource.getCurrentUser();

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('User not found'));
      });
    });
    group('signIn', () {
      test('Should make login', () async {
        // Arrange
        when(() => firebase.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => userCredential);

        // Act
        var (ok, err) = await datasource.signIn(
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(ok, isNotNull);
        expect(ok, isA<bool>());
        expect(ok, isTrue);
        expect(err, isNull);
      });
      test('Should return failure when FirebaseAuthException', () async {
        // Arrange
        when(() => firebase.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(FirebaseAuthException(code: 'code', message: 'msg'));

        // Act
        var (ok, err) = await datasource.signIn(
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(ok, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('msg'));
      });
      test('Should return failure when occurs some Exception', () async {
        // Arrange
        when(() => firebase.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenThrow(Exception('msg'));

        // Act
        var (ok, err) = await datasource.signIn(
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(ok, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('Exception: msg'));
      });
      test('Should return Failure to sign in', () async {
        // Arrange
        userCredential = UserCredentialMock(userMock: null);
        when(() => firebase.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => userCredential);

        // Act
        var (ok, err) = await datasource.signIn(
          email: 'email',
          password: 'password',
        );

        // Assert
        expect(ok, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('Failed to sign in!'));
      });
    });
    group('signOut', () {
      test('Should make sign out', () async {
        // Arrange
        when(() => firebase.signOut()).thenAnswer((_) async {});

        // Act
        var (ok, err) = await datasource.signOut();

        // Assert
        expect(ok, isNotNull);
        expect(ok, isA<bool>());
        expect(ok, isTrue);
        expect(err, isNull);
      });
      test('Should return failure when FirebaseAuthException', () async {
        // Arrange
        when(() => firebase.signOut())
            .thenThrow(FirebaseAuthException(code: 'code', message: 'msg'));

        // Act
        var (ok, err) = await datasource.signOut();

        // Assert
        expect(ok, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('msg'));
      });
      test('Should return failure when occurs some Exception', () async {
        // Arrange
        when(() => firebase.signOut()).thenThrow(Exception('msg'));

        // Act
        var (ok, err) = await datasource.signOut();

        // Assert
        expect(ok, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
        expect(err?.message, equals('Exception: msg'));
      });
    });
  });
}
