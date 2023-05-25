import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/failure.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<(User?, Failure?)> registerUser(UserEntity user);
}
