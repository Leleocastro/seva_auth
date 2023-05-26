import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/utils/base_state.dart';

import '../../../domain/usecases/get_users.dart';

class HomeBloc extends Cubit<BaseState> {
  final GetUsers _getUsers;
  HomeBloc(this._getUsers) : super(const EmptyState());

  void getUsers() async {
    emit(const LoadingState());
    final (users, err) = await _getUsers();
    if (err != null) {
      emit(ErrorState(err.message));
      return;
    }
    emit(SuccessState(users));
  }
}
