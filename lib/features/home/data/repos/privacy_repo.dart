import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:taxi/core/utils/cache_helper.dart';
import 'package:taxi/core/utils/end_points.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/error_model.dart';
import '../models/privacy_model.dart';

class PrivacyRepo {
  Future<Either<String, PrivacyModel>> getPrivacy() async {
    final response = await DioHelper.get(EndPoints.privacy, headers: {
      'lang': CacheHelper.getData(key: 'lang'),
      'page': '2',
    });
    try {
      if (response.statusCode == 200) {
        log("Success PrivacyRepo");
        log(AppStorage.getLang);
       // print(response);
        return Right(PrivacyModel.fromJson(jsonDecode(response.toString())));
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
