import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/repos/support_repo.dart';
part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());

  static SupportCubit of(context) => BlocProvider.of(context);
  final msgController = TextEditingController();
  final supportRepo = SupportRepo();

  Future sendMsgSupport() async {
    emit(SendMsgInitial());
    final res = await supportRepo.sendMsgSupport(msgController.text);
    res.fold(
          (err) {
        showSnackBar(err);
        emit(SendMsgLoading());
      },
          (res) async {
        emit(SendMsgLoaded());
        CacheHelper.getData(key: 'lang') =='en'?showSnackBar('Message sent successfully') :showSnackBar('تم إرسال الرسالة بنجاح');
        msgController.clear();
      },
    );
  }
}

