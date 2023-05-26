import 'package:seva_auth/domain/entities/user_entity.dart';

import '../../utils/failure.dart';

abstract class UserRepository {
  Future<(UserEntity?, Failure?)> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Stream<UserEntity?> getStateAuth();

  (UserEntity?, Failure?) getCurrentUser();

  Future<(bool?, Failure?)> signIn({
    required String email,
    required String password,
  });

  Future<(bool?, Failure?)> signOut();

  Future<(List<UserEntity>?, Failure?)> getUsers();
}
