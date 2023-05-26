import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {}

class LoadingState extends Equatable implements BaseState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends Equatable implements BaseState {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ErrorState extends Equatable implements BaseState {
  final String message;
  final String? errorCode;

  const ErrorState(this.message, [this.errorCode]);

  @override
  List<Object?> get props => [message, errorCode];
}

class EmptyState extends Equatable implements BaseState {
  final String? message;

  const EmptyState({this.message});

  @override
  List<Object?> get props => [];
}
