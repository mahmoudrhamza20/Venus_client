// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/promo_code_model.dart';


class PromoCodeRepo {
  Future<Either<String, PromoCodeModel>> promoCode(
      String coupon) async {
    final response = await DioHelper.post(EndPoints.promoCode, body: {
      'coupon': coupon,
    }, headers: {
      'Accept': 'application/json',
      'lang': AppStorage.getLang,
      'user': CacheHelper.getData(key: 'userId'),

    });
    try {
      if (response.statusCode == 200 && response.data['status'] == true) {
        print("Success promoCodeRepo");
        print(response);
        return Right(PromoCodeModel.fromJson(jsonDecode(response.toString())));
      } else {
        //print(response);
        return Left(ErrorModel.fromJson(jsonDecode(response.toString()))
            .message
            .toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
