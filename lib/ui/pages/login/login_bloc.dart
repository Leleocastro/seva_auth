import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/domain/usecases/sign_in.dart';
import 'package:seva_auth/utils/base_state.dart';

class LoginBloc extends Cubit<BaseState> {
  final SignIn _signIn;
  LoginBloc(this._signIn) : super(const EmptyState());

  void call({
    required String email,
    required String password,
  }) async {
    emit(const LoadingState());

    final (data, err) = await _signIn(
      email: email,
      password: password,
    );
    if (err != null) {
      emit(ErrorState(err.message));
      return;
    }

    emit(SuccessState(data));
  }
}
