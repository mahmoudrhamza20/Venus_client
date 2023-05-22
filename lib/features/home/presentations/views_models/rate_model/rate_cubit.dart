import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/repos/rate_repo.dart';
part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());

  static RateCubit of(context) => BlocProvider.of(context);
  final msgController = TextEditingController();
  final rateRepo = RateRepo();

  Future rating(double rate,int rideId) async {
    emit(SendMsgInitial());
    final res = await rateRepo.rate(msgController.text,rate,rideId);
    res.fold(
          (err) {
        showSnackBar(err.toString());
        emit(SendMsgLoading());
      },
          (res) async {
        emit(SendMsgLoaded());
        print('done');
        CacheHelper.getData(key: 'lang') =='en'?showSnackBar('Message sent successfully') :showSnackBar('تم إرسال الرسالة بنجاح');
        msgController.clear();
      },
    );
  }
}

