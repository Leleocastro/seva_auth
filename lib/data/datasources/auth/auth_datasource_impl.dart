import 'package:firebase_auth/firebase_auth.dart';
import 'package:seva_auth/data/datasources/auth/auth_datasource.dart';
import 'package:seva_auth/data/models/user_model.dart';
import 'package:seva_auth/utils/failure.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _auth;
  const AuthDatasourceImpl(this._auth);

  @override
  Future<(UserModel?, Failure?)> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        return (null, Failure('User not created'));
      }
      response.user!.updateDisplayName(name);

      var user = UserModel(
        id: response.user!.uid,
        name: name,
        email: email,
      );

      return (user, null);
    } on FirebaseAuthException catch (e) {
      return (null, Failure(e.message ?? 'Failed to create user!'));
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Stream<UserModel?> getStateAuth() {
    return _auth.authStateChanges().map<UserModel?>((user) {
      if (user == null) {
        return null;
      }
      return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
    });
  }

  @override
  (UserModel?, Failure?) getCurrentUser() {
    var resp = _auth.currentUser;

    if (resp == null) {
      return (null, Failure('User not found'));
    }

    var user = UserModel(
      id: resp.uid,
      name: resp.displayName ?? '',
      email: resp.email ?? '',
    );

    return (user, null);
  }

  @override
  Future<(bool?, Failure?)> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var resp = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (resp.user == null) {
        return (null, Failure('Failed to sign in!'));
      }

      return (true, null);
    } on FirebaseAuthException catch (e) {
      return (null, Failure(e.message ?? 'Failed to sign in!'));
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(bool?, Failure?)> signOut() async {
    try {
      await _auth.signOut();

      return (true, null);
    } on FirebaseAuthException catch (e) {
      return (null, Failure(e.message ?? 'Failed to sign in!'));
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
