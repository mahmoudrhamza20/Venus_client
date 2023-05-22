part of 'reset_pass_cubit.dart';

abstract class ResetPassState extends Equatable {
  const ResetPassState();
  @override
  List<Object> get props => [];
}

class ResetPassInitial extends ResetPassState {}
class ResetPassLoading extends ResetPassState {}
class ChangeRegisterPasswordVisibility extends ResetPassState {}

