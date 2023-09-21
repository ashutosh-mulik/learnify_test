part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  final String msg;
  const AuthLoading({required this.msg});

  @override
  List<Object> get props => [msg, Random().nextInt(100)];
}

class AuthError extends AuthState {
  final String error;
  const AuthError({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthOTPSent extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthOTPVerified extends AuthState {
  @override
  List<Object> get props => [Random().nextInt(100)];
}
