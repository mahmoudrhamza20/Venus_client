part of 'promo_code_cubit.dart';

abstract class PromoCodeState extends Equatable {
  const PromoCodeState();
  @override
  List<Object> get props => [];
}

class PromoCodeInitial extends PromoCodeState {}
class SendMsgInitial extends PromoCodeState {}

class SendMPromoLoaded extends PromoCodeState {}

class SendMsgLoading extends PromoCodeState {}