part of 'support_cubit.dart';

abstract class SupportState extends Equatable {
  const SupportState();
  @override
  List<Object> get props => [];
}

class SupportInitial extends SupportState {}
class SendMsgInitial extends SupportState {}

class SendMsgLoaded extends SupportState {}

class SendMsgLoading extends SupportState {}