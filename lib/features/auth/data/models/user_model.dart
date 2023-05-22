// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  UserDta data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    data: UserDta.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class UserDta {
  UserDta({
    required this.id,
    required this.name,
    this.userName,
    required this.language,
    required this.phone,
    required this.photo,
  });

  int id;
  String name;
  dynamic userName;

  String language;
  String phone;
  String photo;

  factory UserDta.fromJson(Map<String, dynamic> json) => UserDta(
    id: json["id"],
    name: json["name"],
    userName: json["userName"],
  
    language: json["language"],
    phone: json["phone"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "userName": userName,  
    "language": language,
    "phone": phone,
    "photo": photo,
  };
}
