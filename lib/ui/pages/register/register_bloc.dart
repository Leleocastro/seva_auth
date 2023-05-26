import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/domain/usecases/register_user.dart';
import 'package:seva_auth/utils/base_state.dart';

class RegisterBloc extends Cubit<BaseState> {
  final RegisterUser _registerUser;
  RegisterBloc(this._registerUser) : super(const EmptyState());

  void call({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const LoadingState());
    final (data, err) = await _registerUser(
      name: name,
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
