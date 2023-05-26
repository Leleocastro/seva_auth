import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seva_auth/data/datasources/user/user_datasource.dart';
import 'package:seva_auth/data/models/user_model.dart';
import 'package:seva_auth/utils/failure.dart';

class UserDatasourceImpl implements UserDatasource {
  final FirebaseFirestore _firestore;
  const UserDatasourceImpl(this._firestore);
  @override
  Future<(bool?, Failure?)> saveUser(UserModel userModel) async {
    CollectionReference users = _firestore.collection('users');

    try {
      await users.doc(userModel.id).set(userModel.toJson());

      return (true, null);
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }

  @override
  Future<(List<UserModel>?, Failure?)> getUsers() async {
    CollectionReference<Map<String, dynamic>> users =
        _firestore.collection('users');

    try {
      var querySnapshot = await users.orderBy('name').get();
      var usersList =
          querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
      return (usersList, null);
    } catch (e) {
      return (null, Failure(e.toString()));
    }
  }
}
