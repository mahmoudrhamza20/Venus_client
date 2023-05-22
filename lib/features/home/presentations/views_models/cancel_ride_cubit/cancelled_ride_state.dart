part of 'cancelled_ride_cubit.dart';

abstract class CancelledRideState extends Equatable {
  const CancelledRideState();
  @override
  List<Object> get props => [];
}

class CancelledRideInitial extends CancelledRideState {}
class CancelledRideLoading extends CancelledRideState {}
