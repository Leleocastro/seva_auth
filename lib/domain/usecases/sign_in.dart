import 'package:seva_auth/domain/repositories/user_repository.dart';

import '../../utils/failure.dart';

class SignIn {
  final UserRepository _repository;
  const SignIn(this._repository);

  Future<(bool?, Failure?)> call({
    required String email,
    required String password,
  }) async {
    return await _repository.signIn(
      email: email,
      password: password,
    );
  }
}
