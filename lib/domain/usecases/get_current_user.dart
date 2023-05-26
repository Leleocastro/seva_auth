import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';

import '../../utils/failure.dart';

class GetCurrentUser {
  final UserRepository _repository;
  const GetCurrentUser(this._repository);

  (UserEntity?, Failure?) call() {
    return _repository.getCurrentUser();
  }
}
