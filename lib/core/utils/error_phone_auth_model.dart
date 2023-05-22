// To parse this JSON data, do
//
//     final errorPhoneAuthModel = errorPhoneAuthModelFromJson(jsonString);

import 'dart:convert';

ErrorPhoneAuthModel errorPhoneAuthModelFromJson(String str) =>
    ErrorPhoneAuthModel.fromJson(json.decode(str));

String errorPhoneAuthModelToJson(ErrorPhoneAuthModel data) =>
    json.encode(data.toJson());

class ErrorPhoneAuthModel {
  ErrorPhoneAuthModel({
    required this.errors,
  });

  Errors errors;

  factory ErrorPhoneAuthModel.fromJson(Map<String, dynamic> json) =>
      ErrorPhoneAuthModel(
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors.toJson(),
      };
}

class Errors {
  Errors({
    required this.phone,
  });

  List<String> phone;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        phone: List<String>.from(json["phone"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "phone": List<dynamic>.from(phone.map((x) => x)),
      };
}
