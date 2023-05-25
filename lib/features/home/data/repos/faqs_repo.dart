import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:taxi/core/utils/end_points.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/error_model.dart';
import '../models/faqs_model.dart';

class FaqsRepo {
  Future<Either<String, FaqsModel>> getFaqs() async {
    final response = await DioHelper.get(EndPoints.faqs, headers: {
      'lang': AppStorage.getLang,
    });
    try {
      if (response.statusCode == 200) {
        log("Success GetFaqsRepo");
       // log(response);
        return Right(FaqsModel.fromJson(jsonDecode(response.toString())));
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
