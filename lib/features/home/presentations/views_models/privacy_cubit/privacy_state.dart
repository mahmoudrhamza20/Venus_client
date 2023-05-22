part of 'privacy_cubit.dart';

abstract class PrivacyState extends Equatable {
  const PrivacyState();
  @override
  List<Object> get props => [];
}

class PrivacyInitial extends PrivacyState {}
class PrivacyLoading extends PrivacyState {}
