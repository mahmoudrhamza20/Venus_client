part of 'rate_cubit.dart';

abstract class RateState extends Equatable {
  const RateState();
  @override
  List<Object> get props => [];
}

class RateInitial extends RateState {}
class SendMsgInitial extends RateState {}

class SendMsgLoaded extends RateState {}

class SendMsgLoading extends RateState {}