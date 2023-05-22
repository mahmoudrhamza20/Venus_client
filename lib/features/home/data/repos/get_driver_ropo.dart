import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:taxi/core/utils/end_points.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/error_model.dart';
import '../models/get_driver_model.dart';


class GetDriverRepo {
  Future<Either<String, GetDriverModel>> getDriverDetailsRepo(int rideId) async {
    final response = await DioHelper.get(EndPoints.getDriver, headers: {
      'Accept':'application/json',
      'lang':AppStorage.getLang,
      'ride': rideId,
    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        log("Success GetdriverRepo");
        print(response);
        return Right(GetDriverModel.fromJson(jsonDecode(response.toString())));
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
