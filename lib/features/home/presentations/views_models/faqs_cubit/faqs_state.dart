part of 'faqs_cubit.dart';

abstract class FaqsState extends Equatable {
  const FaqsState();

  @override
  List<Object> get props => [];
}

class FaqsInitial extends FaqsState {}

class FaqsLoading extends FaqsState {}
