import 'package:seva_auth/domain/entities/user_entity.dart';

import '../repositories/user_repository.dart';

class GetStateAuth {
  final UserRepository repository;

  GetStateAuth(this.repository);

  Stream<UserEntity?> call() {
    return repository.getStateAuth();
  }
}
