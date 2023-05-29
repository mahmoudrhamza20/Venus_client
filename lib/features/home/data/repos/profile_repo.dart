import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/dio_helper.dart';
import '../../../../core/utils/end_points.dart';
import '../../../../core/utils/error_model.dart';
import '../../../auth/data/models/user_model.dart';

class ProfileRepo {
  Future<Either<String, UserModel>> getProfileDetails() async {
    final response = await DioHelper.get(EndPoints.profile, headers: {
      'lang': AppStorage.getLang,
      'client': CacheHelper.getData(key: 'userId'),
    });
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success GetProfileDetailsRepo");
        return Right(UserModel.fromJson(jsonDecode(response.toString())));
      } else {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString()))
            .message
            .toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> editProfileDetails(
      String name,
      String phone,
  
      ) async {
    FormData body = FormData.fromMap({
      "name": name,
      "phone": phone,
      
    });

    final response = await DioHelper.post(EndPoints.updateProfile,
        headers: {
          'user': CacheHelper.getData(key: 'userId'),
          'lang': AppStorage.getLang,
          'Accept': 'application/json',
        },
        formData: body);
   // print(email);
    print(phone);
    print(name);
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print("Success EditProfileDetailsRepo");
        return Right(UserModel.fromJson(jsonDecode(response.toString())));

      } else {
        return Left(ErrorModel.fromJson(jsonDecode(response.toString()))
            .message
            .toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> editImageProfile(
      XFile photo,
      ) async {
    String fileName = photo.path.split('/').last;
    FormData body = FormData.fromMap({
      "photo": await MultipartFile.fromFile(photo.path, filename: fileName),
    });
    print(fileName);
    print(photo.path);
    //log(CacheHelper.getData(key: 'userId'));
    final response = await DioHelper.post(EndPoints.updateProfile,
        headers: {
          'lang': AppStorage.getLang,
          'user': CacheHelper.getData(key: 'userId'),
          'Accept': 'application/json',
        },
        formData: body);
    try {
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        log("Success EditImageProfileRepo");
        return Right(UserModel.fromJson(jsonDecode(response.toString())));
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
