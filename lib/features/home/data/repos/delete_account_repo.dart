// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../models/delete_account_model.dart';

class DeleteAccountRepo {
  Future<Either<String, DeleteAccountModel>> deleteAccount() async {
    final response = await DioHelper.get(EndPoints.deleteAccount,  headers: {
      'lang': AppStorage.getLang,
      'client': CacheHelper.getData(key:'userId'),


    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success LoginRepo");
        print(response);
        return Right(DeleteAccountModel.fromJson(jsonDecode(response.toString())));
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
