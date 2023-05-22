// To parse this JSON data, do
//
//     final faqsModel = faqsModelFromJson(jsonString);

import 'dart:convert';
import '../../../../core/utils/app_storage.dart';


FaqsModel faqsModelFromJson(String str) => FaqsModel.fromJson(json.decode(str));

String faqsModelToJson(FaqsModel data) => json.encode(data.toJson());

class FaqsModel {
  FaqsModel({
    required this.status,
    required this.data,
  });

  String status;
  List<FaqsData> data;

  factory FaqsModel.fromJson(Map<String, dynamic> json) => FaqsModel(
        status: json["status"],
        data:
            List<FaqsData>.from(json["data"].map((x) => FaqsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FaqsData {
  FaqsData({
    required this.question,
    required this.answer,
  });

  String question;
  String answer;

  factory FaqsData.fromJson(Map<String, dynamic> json) => FaqsData(
        question: AppStorage.getLang == "ar"
            ? json["question_ar"]
            : json["question_en"],
        answer:
            AppStorage.getLang == "ar" ? json["answer_ar"] : json["answer_en"],
      );

  Map<String, dynamic> toJson() => {
        AppStorage.getLang == "ar" ? "question_ar" : "question_en": question,
        AppStorage.getLang == "ar" ? "answer_ar" : "answer_en": answer,
      };
}
