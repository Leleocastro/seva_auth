import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/utils/failure.dart';

import '../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<(List<UserEntity>?, Failure?)> call() async {
    return await repository.getUsers();
  }
}
