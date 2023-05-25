import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/domain/usecases/register_user_usecase.dart';
import 'package:seva_auth/utils/base_state.dart';

class RegisterBloc extends Cubit<BaseState> {
  final RegisterUserUseCase _useCase;
  RegisterBloc(this._useCase) : super(const EmptyState());

  void call(UserEntity user) async {
    emit(const LoadingState());
    var (data, err) = await _useCase.call(user);
    if (err != null) {
      emit(ErrorState(err.message));
      return;
    }
    emit(SuccessState(data));
  }
}
