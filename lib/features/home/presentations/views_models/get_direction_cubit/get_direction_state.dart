part of 'get_direction_cubit.dart';

abstract class GetDirectionState extends Equatable {
  const GetDirectionState();
  @override
  List<Object> get props => [];
}

class GetDirectionInitial extends GetDirectionState {}
class GetDirectionLoading extends GetDirectionState {}
class GetDirectionLoad extends GetDirectionState {}
class GetDirectionFinish extends GetDirectionState {}
class GetDirectionFinish2 extends GetDirectionState {}
class GetDirectionGetRequest extends GetDirectionState {}
class GetDirectionDoneRequest extends GetDirectionState {}
class GetDriverDataLoaded extends GetDirectionState {}
class GetDriverDataLoading extends GetDirectionState {}
class GetDriverDataLoadingDone extends GetDirectionState {}
class GetDriverDataLoad extends GetDirectionState {}
class PolyLoaded extends GetDirectionState {}
class PolyLoading extends GetDirectionState {}
// class GetDirectionGetRequest extends GetDirectionState {}
// class GetDirectionDoneRequest extends GetDirectionState {}
