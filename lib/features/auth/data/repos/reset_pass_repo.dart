// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:taxi/features/auth/data/models/reset_pass_model.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';

class ResetPassRepo {
  Future<Either<String, ResetPassModel>> resetPass(
       String password,String passwordConfirmation) async {
    final response = await DioHelper.post(EndPoints.resetPass, body: {
      'password': password,
      'password_confirmation': passwordConfirmation,
    },
    headers: {
      'lang': AppStorage.getLang,
      'user': CacheHelper.getData(key: 'userId'),
    }
    );
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success ResetPassRepo");
        print(response);
        return Right(ResetPassModel.fromJson(jsonDecode(response.toString())));
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
