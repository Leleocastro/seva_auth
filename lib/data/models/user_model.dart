import 'package:seva_auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(
          id: id,
          name: name,
          email: email,
        );
}
