// To parse this JSON data, do
//
//     final resetPassModel = resetPassModelFromJson(jsonString);

import 'dart:convert';

ResetPassModel resetPassModelFromJson(String str) => ResetPassModel.fromJson(json.decode(str));

String resetPassModelToJson(ResetPassModel data) => json.encode(data.toJson());

class ResetPassModel {
  ResetPassModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  bool data;

  factory ResetPassModel.fromJson(Map<String, dynamic> json) => ResetPassModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
