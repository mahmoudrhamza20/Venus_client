part of 'get_driver_cubit.dart';

abstract class GetDriverState extends Equatable {
  const GetDriverState();
  @override
  List<Object> get props => [];
}

class GetDriverInitial extends GetDriverState {}
class GetDriverLoading extends GetDriverState {}
class GetDriverDone extends GetDriverState {}
