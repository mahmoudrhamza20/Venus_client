// To parse this JSON data, do
//
//     final cancelSearchModel = cancelSearchModelFromJson(jsonString);

import 'dart:convert';

CancelSearchModel cancelSearchModelFromJson(String str) => CancelSearchModel.fromJson(json.decode(str));

String cancelSearchModelToJson(CancelSearchModel data) => json.encode(data.toJson());

class CancelSearchModel {
    CancelSearchModel({
        required this.status,
        required this.message,
        this.data,
    });

    String status;
    String message;
    dynamic data;

    factory CancelSearchModel.fromJson(Map<String, dynamic> json) => CancelSearchModel(
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