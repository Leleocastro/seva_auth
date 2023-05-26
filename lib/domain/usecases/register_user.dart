import 'package:seva_auth/domain/entities/user_entity.dart';

import '../../utils/failure.dart';
import '../repositories/user_repository.dart';

class RegisterUser {
  final UserRepository _repository;

  RegisterUser(this._repository);

  Future<(UserEntity?, Failure?)> call({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.isEmpty) {
      return (null, Failure('Name cannot be empty!'));
    }
    if (email.isEmpty || !email.contains('@')) {
      return (null, Failure('Invalid email!'));
    }
    if (password.isEmpty || password.length < 6) {
      return (null, Failure('Invalid password!'));
    }

    return await _repository.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }
}
