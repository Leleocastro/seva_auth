import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/utils/base_state.dart';

class LoginBloc extends Cubit<BaseState> {
  LoginBloc() : super(const EmptyState());

  void call() async {
    emit(const LoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(const ErrorState('Aconteceu um erro inesperado'));
  }
}
