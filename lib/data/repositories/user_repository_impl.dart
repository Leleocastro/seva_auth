import 'package:seva_auth/data/datasources/user/user_datasource.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/utils/failure.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _datasource;
  const UserRepositoryImpl(this._datasource);

  @override
  Future<(UserEntity?, Failure?)> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _datasource.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Stream<UserEntity?> getStateAuth() {
    return _datasource.getStateAuth();
  }

  @override
  Future<(UserEntity?, Failure?)> getCurrentUser() async {
    return await _datasource.getCurrentUser();
  }

  @override
  Future<(bool?, Failure?)> signIn({
    required String email,
    required String password,
  }) async {
    return await _datasource.signIn(
      email: email,
      password: password,
    );
  }
}
