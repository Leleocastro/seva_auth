import 'package:seva_auth/domain/repositories/user_repository.dart';

import '../../utils/failure.dart';

class SignOut {
  final UserRepository _repository;
  const SignOut(this._repository);

  Future<(bool?, Failure?)> call() async {
    return await _repository.signOut();
  }
}
