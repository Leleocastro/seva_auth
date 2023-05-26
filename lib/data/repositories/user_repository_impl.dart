import 'package:seva_auth/data/datasources/auth/auth_datasource.dart';
import 'package:seva_auth/data/datasources/user/user_datasource.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthDatasource _authDatasource;
  final UserDatasource _userDatasource;
  const UserRepositoryImpl(
    this._authDatasource,
    this._userDatasource,
  );

  @override
  Future<(UserEntity?, Failure?)> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    var (user, err) = await _authDatasource.registerUser(
      name: name,
      email: email,
      password: password,
    );
    if (err != null) {
      return (null, Failure('Failed to register user!'));
    }

    var (_, err2) = await _userDatasource.saveUser(user!);
    if (err2 != null) {
      //TODO: delete user in auth
      return (null, Failure('Failed to save user!'));
    }

    return (user, null);
  }

  @override
  Stream<UserEntity?> getStateAuth() {
    return _authDatasource.getStateAuth();
  }

  @override
  (UserEntity?, Failure?) getCurrentUser() {
    return _authDatasource.getCurrentUser();
  }

  @override
  Future<(bool?, Failure?)> signIn({
    required String email,
    required String password,
  }) async {
    return await _authDatasource.signIn(
      email: email,
      password: password,
    );
  }

  @override
  Future<(List<UserEntity>?, Failure?)> getUsers() async {
    return await _userDatasource.getUsers();
  }

  @override
  Future<(bool?, Failure?)> signOut() async {
    return await _authDatasource.signOut();
  }
}
