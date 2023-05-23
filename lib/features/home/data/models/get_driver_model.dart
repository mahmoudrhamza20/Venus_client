// To parse this JSON data, do
//
//     final getDriverModel = getDriverModelFromJson(jsonString);

import 'dart:convert';

GetDriverModel getDriverModelFromJson(String str) => GetDriverModel.fromJson(json.decode(str));

String getDriverModelToJson(GetDriverModel data) => json.encode(data.toJson());

class GetDriverModel {
    String status;
    String message;
    GetDriverData data;

    GetDriverModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetDriverModel.fromJson(Map<String, dynamic> json) => GetDriverModel(
        status: json["status"],
        message: json["message"],
        data: GetDriverData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class GetDriverData {
    int id;
    int user;
    String name;
    String userName;
    String email;
    String language;
    String phone;
    String avabile;
    String identityCardNumber;
    String license;
    dynamic deviceToken;
    String photo;
    String carType;
    int carBoard;
    dynamic wallets;
    int rides;
    int rates;
    dynamic rating;
   

    GetDriverData({
        required this.id,
        required this.user,
        required this.name,
        required this.userName,
        required this.email,
        required this.language,
        required this.phone,
        required this.avabile,
        required this.identityCardNumber,
        required this.license,
        this.deviceToken,
        required this.photo,
        required this.carType,
        required this.carBoard,
        required this.wallets,
        required this.rides,
        required this.rates,
        required this.rating,
    
    });

    factory GetDriverData.fromJson(Map<String, dynamic> json) => GetDriverData(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        userName: json["userName"],
        email: json["email"],
        language: json["language"],
        phone: json["phone"],
        avabile: json["avabile"],
        identityCardNumber: json["identityCardNumber"],
        license: json["License"],
        deviceToken: json["device_token"],
        photo: json["photo"],
        carType: json["carType"],
        carBoard: json["carBoard"],
        wallets: json["wallets"],
        rides: json["rides"],
        rates: json["rates"],
        rating: json["rating"],
      
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "userName": userName,
        "email": email,
        "language": language,
        "phone": phone,
        "avabile": avabile,
        "identityCardNumber": identityCardNumber,
        "License": license,
        "device_token": deviceToken,
        "photo": photo,
        "carType": carType,
        "carBoard": carBoard,
        "wallets": wallets,
        "rides": rides,
        "rates": rates,
        "rating": rating,
        
    };
}
