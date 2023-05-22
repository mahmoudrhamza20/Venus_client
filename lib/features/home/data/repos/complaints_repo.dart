// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/complaints_model.dart';


class ComplaintsRepo {
  Future<Either<String, ComplaintsModel>> sendMsgComplaints(
      String msg, int rideId) async {
    final response = await DioHelper.post(EndPoints.sentMsgComplaints, body: {
      'details': msg,
    }, headers: {
      'Accept': 'application/json',
      'lang': AppStorage.getLang,
      'ride':rideId


    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success ComplaintsRepo");
        print(response);
        return Right(ComplaintsModel.fromJson(jsonDecode(response.toString())));
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
