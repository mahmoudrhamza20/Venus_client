import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/faqs_model.dart';
import '../../../data/repos/faqs_repo.dart';
part 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqsState> {
  FaqsCubit() : super(FaqsInitial());
  final faqsRepo = FaqsRepo();

  static FaqsCubit of(context) => BlocProvider.of(context);

  List<FaqsData> listOfFAQsData = [];

  Future getFAQs() async {
    emit(FaqsLoading());
    final res = await faqsRepo.getFaqs();
    res.fold(
      (err) {
        showSnackBar(err);
        emit(FaqsInitial());
      },
      (res) async {
        listOfFAQsData = res.data;
        emit(FaqsInitial());
      },
    );
  }
}
