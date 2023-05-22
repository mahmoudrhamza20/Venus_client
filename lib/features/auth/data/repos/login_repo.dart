// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/user_model.dart';

class LoginRepo {
  Future<Either<String, UserModel>> login(
      String email, String password) async {
    final response = await DioHelper.post(EndPoints.login, body: {
      'email': email,
      'password': password,
    },
    headers: {
      'Accept': 'application/json',
      'lang': AppStorage.getLang,
    }
    );
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success LoginRepo");
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
