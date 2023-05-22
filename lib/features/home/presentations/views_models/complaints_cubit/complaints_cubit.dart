import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/repos/Complaints_repo.dart';
part 'complaints_state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit() : super(ComplaintsInitial());

  static ComplaintsCubit of(context) => BlocProvider.of(context);
  final msgController = TextEditingController();
  final complaintsRepo = ComplaintsRepo();

  Future sendMsgComplaints( int rideId) async {
    emit(SendMsgInitial());
    final res = await complaintsRepo.sendMsgComplaints(msgController.text,rideId);
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

