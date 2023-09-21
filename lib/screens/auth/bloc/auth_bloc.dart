import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String _country = '';
  String _phone = '';

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<SendOTP>(_mapSendOTPToState);
    on<VerifyOTP>(_mapVerifyOTPToState);
  }

  FutureOr<void> _mapSendOTPToState(SendOTP event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(msg: "Sending OTP..."));
    _country = event.country;
    _phone = event.phone;
    await Future.delayed(const Duration(seconds: 5));
    emit(AuthOTPSent());
  }

  FutureOr<void> _mapVerifyOTPToState(VerifyOTP event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(msg: "Verifying OTP..."));
    await Future.delayed(const Duration(seconds: 5));
    emit(AuthOTPVerified());
  }
}
