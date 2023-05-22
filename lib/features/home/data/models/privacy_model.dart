// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';

import 'package:taxi/core/utils/cache_helper.dart';

PrivacyModel privacyModelFromJson(String str) =>
    PrivacyModel.fromJson(json.decode(str));

String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
  PrivacyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  PrivacyData data;

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
        status: json["status"],
        message: json["message"],
        data: PrivacyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class PrivacyData {
  PrivacyData({
    required this.title,
    required this.content,
  });

  String title;
  String content;

  factory PrivacyData.fromJson(Map<String, dynamic> json) => PrivacyData(
        title: CacheHelper.getData(key: 'lang') == "ar"
            ? json["title_ar"]
            : json["title_en"],
        content: CacheHelper.getData(key: 'lang') == "ar"
            ? json["content_ar"]
            : json["content_en"],
      );

  Map<String, dynamic> toJson() => {
        CacheHelper.getData(key: 'lang') == "ar" ? "title_ar" : "title_en":
            title,
        CacheHelper.getData(key: 'lang') == "ar" ? "content_ar" : "content_en":
            content,
      };
}
