part of 'ride_history_cubit.dart';

abstract class RideHistoryState extends Equatable {
  const RideHistoryState();

  @override
  List<Object> get props => [];
}

class RideHistoryInitial extends RideHistoryState {}

class RideHistoryLoading extends RideHistoryState {}
