// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/user_model.dart';

class RegisterRepo {
  Future<Either<String, UserModel>> register(String name,
      String phone, String password, String conPassword) async {
    final response = await DioHelper.post(EndPoints.register, body: {
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': conPassword,
    }, headers: {
      'Accept': 'application/json',
      'lang': AppStorage.getLang,
    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success RegisterRepo");
        print(response);
        return Right(UserModel.fromJson(jsonDecode(response.toString())));
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
