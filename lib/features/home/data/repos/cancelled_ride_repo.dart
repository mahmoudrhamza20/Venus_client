// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/cancel_ride_model.dart';


class CancelledRideRepo {

  Future<Either<String, CancelRideModel>> cancelRide({required String reason,required int rideId}) async {
    final response = await DioHelper.post(EndPoints.cancelledRide, body: {
      'reasonCancelled': reason,
      'cancelTime':DateFormat.jm().format(DateTime.now()),
      'client': CacheHelper.getData(key:'userId'),
    }, headers: {
      'lang': AppStorage.getLang,
      'ride':rideId,
      'type':'client'
    });

    print(reason);
    print(DateFormat.jm().format(DateTime.now()),);
    print(CacheHelper.getData(key:'userId'),);
    print(rideId);
    try {
      if (response.statusCode == 200 ) {
        print("Success CancelledRideRepo");
        print(response);
        return Right(CancelRideModel.fromJson(jsonDecode(response.toString())));
      } else {
        print(response);
        return Left(ErrorModel.fromJson(jsonDecode(response.toString()))
            .message
            .toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
