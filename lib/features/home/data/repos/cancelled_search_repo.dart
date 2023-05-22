// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/cancel_search_modrl.dart';
import '../models/send_msg_model.dart';


class CancelledSearchRepo {
  Future<Either<String, CancelSearchModel>> cancelSearch(int rideId) async {
    final response = await DioHelper.get(EndPoints.cancelledSearch,
        headers: {
      'lang': AppStorage.getLang,
      'client': CacheHelper.getData(key:'userId'),
        'ride':rideId,

    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success CancelledSearchRepo");
        print(response);
        return Right(CancelSearchModel.fromJson(jsonDecode(response.toString())));
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
