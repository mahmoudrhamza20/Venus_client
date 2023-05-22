part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class SendMsgInitial extends ContactUsState {}

class SendMsgLoaded extends ContactUsState {}

class SendMsgLoading extends ContactUsState {}
