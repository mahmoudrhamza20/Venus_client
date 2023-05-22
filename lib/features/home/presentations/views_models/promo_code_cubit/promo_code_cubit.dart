import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/promo_code_model.dart';
import '../../../data/repos/promo_code_repo.dart';
part 'promo_code_state.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  PromoCodeCubit() : super(PromoCodeInitial());

  static PromoCodeCubit of(context) => BlocProvider.of(context);
  final couponController = TextEditingController();
  final promoCodeRepo = PromoCodeRepo();
  PromoCodeModel? promoCodeModel;

  Future promoCode() async {
    emit(SendMsgInitial());
    final res = await promoCodeRepo.promoCode(couponController.text);
    res.fold(
          (err) {
        showSnackBar(err.toString(),margin: EdgeInsets.only(bottom: 500.h,left: 25.w,right: 25.w));
        emit(SendMsgLoading());
      },
          (res) async {
        emit(SendMPromoLoaded());
         promoCodeModel = res;
        log('promo Code');
        log('${res.coupon.id}');
        log(res.coupon.value);
       log('${promoCodeModel!.status}');
        log('promo Code');
       
       
        showSnackBar(res.message,margin: EdgeInsets.only(bottom: 500.h,left: 25.w,right: 25.w));
       // CacheHelper.getData(key: 'lang') =='en'?showSnackBar('Message sent successfully') :showSnackBar('تم إرسال الرسالة بنجاح');
        couponController.clear();
      },
    );
  }
}

