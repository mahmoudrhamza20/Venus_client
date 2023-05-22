part of 'cancelled_search_cubit.dart';

abstract class CancelledSearchState extends Equatable {
  const CancelledSearchState();
  @override
  List<Object> get props => [];
}

class CancelledSearchInitial extends CancelledSearchState {}
class CancelledSearchLoading extends CancelledSearchState {}
class CancelledSearchSuc extends CancelledSearchState {}
