part of 'histoty_ride_details_cubit.dart';

abstract class HistotyRideDetailsState extends Equatable {
  const HistotyRideDetailsState();
  @override
  List<Object> get props => [];
}

class HistotyRideDetailsInitial extends HistotyRideDetailsState {}
class HistotyRideDetailsLoading extends HistotyRideDetailsState {}
