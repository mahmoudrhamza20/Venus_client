// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/send_msg_model.dart';

class SupportRepo {
  Future<Either<String, SendMsgModel>> sendMsgSupport(String msg) async {
    final response = await DioHelper.post(EndPoints.sentMsgContactUs, body: {
      'content': msg,
    }, headers: {
      'Accept': 'application/json',
      'lang': AppStorage.getLang,
      'userId': CacheHelper.getData(key: 'userId'),
      'userType': "client",
      'subject': "support",

    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success SupportRepo");
        print(response);
        return Right(SendMsgModel.fromJson(jsonDecode(response.toString())));
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
