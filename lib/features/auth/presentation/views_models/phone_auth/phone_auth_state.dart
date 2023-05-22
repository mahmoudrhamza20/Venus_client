part of 'phone_auth_cubit.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOccurred extends PhoneAuthState {
  final String errorMsg;

  const ErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmited extends PhoneAuthState {}

class CodeSend extends PhoneAuthState {}

class PhoneOTPVerified extends PhoneAuthState {}
