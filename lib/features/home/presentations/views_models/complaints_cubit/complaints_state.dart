part of 'complaints_cubit.dart';

abstract class ComplaintsState extends Equatable {
  const ComplaintsState();
  @override
  List<Object> get props => [];
}

class ComplaintsInitial extends ComplaintsState {}
class SendMsgInitial extends ComplaintsState {}

class SendMsgLoaded extends ComplaintsState {}

class SendMsgLoading extends ComplaintsState {}