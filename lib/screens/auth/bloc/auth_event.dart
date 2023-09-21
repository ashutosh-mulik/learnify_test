part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SendOTP extends AuthEvent {
  final String country;
  final String phone;
  const SendOTP({required this.country, required this.phone});

  @override
  List<Object?> get props => [country, phone];
}

class VerifyOTP extends AuthEvent {
  final String code;
  const VerifyOTP({required this.code});

  @override
  List<Object?> get props => [code];
}
