// To parse this JSON data, do
//
//     final complaintsModel = complaintsModelFromJson(jsonString);

import 'dart:convert';

ComplaintsModel complaintsModelFromJson(String str) => ComplaintsModel.fromJson(json.decode(str));

String complaintsModelToJson(ComplaintsModel data) => json.encode(data.toJson());

class ComplaintsModel {
    ComplaintsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    List<dynamic> data;

    factory ComplaintsModel.fromJson(Map<String, dynamic> json) => ComplaintsModel(
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