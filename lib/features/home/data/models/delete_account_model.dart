// To parse this JSON data, do
//
//     final deleteAccountModel = deleteAccountModelFromJson(jsonString);

import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) => json.encode(data.toJson());

class DeleteAccountModel {
  DeleteAccountModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<dynamic> data;

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
