import 'package:get_it/get_it.dart';
import 'package:seva_auth/ui/pages/register/register_bloc.dart';

class MainBindings {
  static void init() {
    GetIt.I.registerFactory<RegisterBloc>(() => RegisterBloc(GetIt.I.get()));
  }
}
