import '../../../utils/failure.dart';
import '../../models/user_model.dart';

abstract class AuthDatasource {
  Future<(UserModel?, Failure?)> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Stream<UserModel?> getStateAuth();

  (UserModel?, Failure?) getCurrentUser();

  Future<(bool?, Failure?)> signIn({
    required String email,
    required String password,
  });
}
