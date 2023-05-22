import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/privacy_model.dart';
import '../../../data/repos/privacy_repo.dart';
part 'privacy_state.dart';


class PrivacyCubit extends Cubit<PrivacyState> {
  PrivacyCubit() : super(PrivacyInitial());

  final privacyRepo = PrivacyRepo();

  static PrivacyCubit of(context) => BlocProvider.of(context);
  PrivacyData? privacyData;

  Future getPrivacy() async {
    emit(PrivacyLoading());
    final res = await privacyRepo.getPrivacy();
    res.fold(
          (err) {
        showSnackBar(err);
        emit(PrivacyInitial());
      },
          (res) async {
            privacyData = res.data;
        emit(PrivacyInitial());
      },
    );
  }



}
