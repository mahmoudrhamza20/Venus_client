import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:taxi/core/utils/end_points.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/error_model.dart';
import '../models/history_ride_model.dart';

class RideHistoryRepo {
  Future<Either<String, RideHistoryModel>> getRideHistory() async {
    final response = await DioHelper.get(EndPoints.getHistoryRide, headers: {
      'lang': AppStorage.getLang,
      'typeId': CacheHelper.getData(key: 'userId'),
      'type': 'client',
    });
    try {
      if (response.statusCode == 200) {
        print("Success RideHistoryRepo");
        print(response);
        
        return Right(RideHistoryModel.fromJson(jsonDecode(response.toString())));
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
