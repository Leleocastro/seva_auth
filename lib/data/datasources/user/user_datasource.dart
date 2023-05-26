import '../../../utils/failure.dart';
import '../../models/user_model.dart';

abstract class UserDatasource {
  Future<(bool?, Failure?)> saveUser(UserModel userModel);
  Future<(List<UserModel>?, Failure?)> getUsers();
}
