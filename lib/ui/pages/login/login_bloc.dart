import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/domain/usecases/sign_in.dart';
import 'package:seva_auth/utils/base_state.dart';

import '../../../domain/usecases/sign_out.dart';

class LoginBloc extends Cubit<BaseState> {
  final SignIn _signIn;
  final SignOut _signOut;
  LoginBloc(
    this._signIn,
    this._signOut,
  ) : super(const EmptyState());

  void login({
    required String email,
    required String password,
  }) async {
    emit(const LoadingState());

    final (ok, err) = await _signIn(
      email: email,
      password: password,
    );
    if (err != null) {
      emit(ErrorState(err.message));
      return;
    }

    emit(SuccessState(ok));
  }

  void logout() async {
    emit(const LoadingState());

    final (ok, err) = await _signOut();
    if (err != null) {
      emit(ErrorState(err.message));
      return;
    }

    emit(SuccessState(ok));
  }
}
