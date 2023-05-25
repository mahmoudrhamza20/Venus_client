import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:taxi/core/utils/end_points.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/error_model.dart';
import '../models/history_ride_details_model.dart';


class HistoryRideDetailsRepo {
  Future<Either<String, HistotyRideDetailsModel>> getHistoryRideDetails(int rideId) async {
    final response = await DioHelper.get(EndPoints.getHistoryRideDetails, headers: {
      'lang': AppStorage.getLang,
      'ride': rideId,
    });
    try {
      if (response.statusCode == 200) {
        log("Success HistoryRideDetailsRepo");
        log(AppStorage.getLang);
        print(response);
        return Right(HistotyRideDetailsModel.fromJson(jsonDecode(response.toString())));
      } else {
       
        return Left(ErrorModel.fromJson(jsonDecode(response.toString()))
            .message
            .toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
