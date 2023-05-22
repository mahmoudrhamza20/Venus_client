part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetProfileDetailsLoading extends ProfileState {}

class GetProfileDetailsLoaded extends ProfileState {}

class EditProfileDetailsLoading extends ProfileState {}
