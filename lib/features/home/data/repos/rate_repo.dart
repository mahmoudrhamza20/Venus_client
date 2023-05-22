// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/rating_model.dart';


class RateRepo {
  Future<Either<String, RateModel>> rate(
      String msg,double rate, int rideId) async {
    final response = await DioHelper.post(EndPoints.rating, body: {
      'message': msg,
      'rate': rate,
    }, headers: {
      'lang': AppStorage.getLang,
      'ride':rideId
    });
    try {
      if (response.statusCode == 200 && response.data['status'] == true) {
        print("Success rateRepo");
        print(response);
        return Right(RateModel.fromJson(jsonDecode(response.toString())));
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
