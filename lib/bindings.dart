import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/data/datasources/user/user_datasource.dart';
import 'package:seva_auth/data/datasources/user/user_datasource_impl.dart';
import 'package:seva_auth/data/repositories/user_repository_impl.dart';
import 'package:seva_auth/domain/repositories/user_repository.dart';
import 'package:seva_auth/domain/usecases/get_current_user.dart';
import 'package:seva_auth/domain/usecases/get_state_auth.dart';
import 'package:seva_auth/domain/usecases/register_user.dart';
import 'package:seva_auth/domain/usecases/sign_in.dart';
import 'package:seva_auth/ui/pages/login/login_bloc.dart';
import 'package:seva_auth/ui/pages/register/register_bloc.dart';

class MainBindings {
  static void init() {
    // Instances
    GetIt.I.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    // Datasources
    GetIt.I.registerFactory<UserDatasource>(
        () => UserDatasourceImpl(GetIt.I.get()));

    // Repositories
    GetIt.I.registerFactory<UserRepository>(
        () => UserRepositoryImpl(GetIt.I.get()));

    // Usecases
    GetIt.I.registerFactory<RegisterUser>(() => RegisterUser(GetIt.I.get()));
    GetIt.I.registerFactory<SignIn>(() => SignIn(GetIt.I.get()));
    GetIt.I
        .registerFactory<GetCurrentUser>(() => GetCurrentUser(GetIt.I.get()));
    GetIt.I
        .registerLazySingleton<GetStateAuth>(() => GetStateAuth(GetIt.I.get()));
    GetIt.I.registerFactory<RegisterBloc>(() => RegisterBloc(GetIt.I.get()));
    GetIt.I.registerFactory<LoginBloc>(() => LoginBloc(GetIt.I.get()));
  }
}
