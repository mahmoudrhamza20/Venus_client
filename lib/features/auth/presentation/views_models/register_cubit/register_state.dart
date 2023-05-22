part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class ErrorOccurred extends RegisterState {
  final String errorMsg;
   ErrorOccurred({required this.errorMsg});
}
class Loading extends RegisterState {}
class PhoneOTPVerified extends RegisterState {}
class PhoneNumberSubmited extends RegisterState {}

class ChangeRegisterPasswordVisibility extends RegisterState {
}
