import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository _repository;

  RegisterUserUseCase(this._repository);

  Future<(User?, Failure?)> call(UserEntity user) async {
    return await _repository.registerUser(user);
  }
}
