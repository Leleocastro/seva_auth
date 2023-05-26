import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/data/datasources/auth/auth_datasource.dart';
import 'package:seva_auth/data/datasources/auth/auth_datasource_impl.dart';
import 'package:seva_auth/data/repositories/user_repository_impl.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/get_current_user.dart';
import 'package:seva_auth/domain/usecases/get_state_auth.dart';
import 'package:seva_auth/domain/usecases/get_users.dart';
import 'package:seva_auth/domain/usecases/register_user.dart';
import 'package:seva_auth/domain/usecases/sign_in.dart';
import 'package:seva_auth/ui/pages/home/home_bloc.dart';
import 'package:seva_auth/ui/pages/login/login_bloc.dart';
import 'package:seva_auth/ui/pages/register/register_bloc.dart';

import 'data/datasources/user/user_datasource.dart';
import 'data/datasources/user/user_datasoure_impl.dart';

class MainBindings {
  static void init() {
    // Instances
    GetIt.I.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    GetIt.I.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);

    // Datasources
    GetIt.I.registerFactory<AuthDatasource>(
        () => AuthDatasourceImpl(GetIt.I.get()));
    GetIt.I.registerFactory<UserDatasource>(
        () => UserDatasourceImpl(GetIt.I.get()));

    // Repositories
    GetIt.I.registerFactory<UserRepository>(
        () => UserRepositoryImpl(GetIt.I.get(), GetIt.I.get()));

    // Usecases
    GetIt.I.registerFactory<RegisterUser>(() => RegisterUser(GetIt.I.get()));
    GetIt.I.registerFactory<SignIn>(() => SignIn(GetIt.I.get()));
    GetIt.I
        .registerFactory<GetCurrentUser>(() => GetCurrentUser(GetIt.I.get()));
    GetIt.I
        .registerLazySingleton<GetStateAuth>(() => GetStateAuth(GetIt.I.get()));
    GetIt.I.registerLazySingleton<GetUsers>(() => GetUsers(GetIt.I.get()));

    // Blocs
    GetIt.I.registerFactory<RegisterBloc>(() => RegisterBloc(GetIt.I.get()));
    GetIt.I.registerFactory<LoginBloc>(() => LoginBloc(GetIt.I.get()));
    GetIt.I.registerFactory<HomeBloc>(() => HomeBloc(GetIt.I.get()));
  }
}
