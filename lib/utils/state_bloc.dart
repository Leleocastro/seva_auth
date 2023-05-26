import 'package:flutter_bloc/flutter_bloc.dart';

class StateBloc<T> extends Cubit<T> {
  StateBloc(T value) : super(value);

  void call(T value) {
    emit(value);
  }
}
