// To parse this JSON data, do
//
//     final sendMsgModel = sendMsgModelFromJson(jsonString);

import 'dart:convert';

SendMsgModel sendMsgModelFromJson(String str) =>
    SendMsgModel.fromJson(json.decode(str));

String sendMsgModelToJson(SendMsgModel data) => json.encode(data.toJson());

class SendMsgModel {
  SendMsgModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<dynamic> data;

  factory SendMsgModel.fromJson(Map<String, dynamic> json) => SendMsgModel(
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
