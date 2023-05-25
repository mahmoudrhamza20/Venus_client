// To parse this JSON data, do
//
//     final contactUs = contactUsFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsFromJson(String str) =>
    ContactUsModel.fromJson(json.decode(str));

String contactUsToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  ContactUsData data;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        status: json["status"],
        message: json["message"],
        data: ContactUsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ContactUsData {
  ContactUsData({
    required this.titleEn,
    required this.addressEn,
    required this.whatsPhone,
    required this.email,
    required this.facebook,
    required this.snapchat,
    required this.tiktok,
    required this.whatsapp,
    required this.instgram,
    required this.twitter,
    required this.youtube,
  });

  String? titleEn;
  String? addressEn;
  String? whatsPhone;
  String? email;
  String? facebook;
  String? snapchat;
  String? tiktok;
  String? whatsapp;
  String? instgram;
  String? twitter;
  String? youtube;

  factory ContactUsData.fromJson(Map<String, dynamic> json) => ContactUsData(
        titleEn: json["title_en"],
        addressEn: json["address_en"],
        whatsPhone: json["whats_phone"],
        email: json["email"],
        facebook: json["facebook"],
        snapchat: json["snapchat"],
        tiktok: json["tiktok"],
        whatsapp: json["whatsapp"],
        instgram: json["instgram"],
        twitter: json["twitter"],
        youtube: json["youtube"],
      );

  Map<String, dynamic> toJson() => {
        "title_en": titleEn,
        "address_en": addressEn,
        "whats_phone": whatsPhone,
        "email": email,
        "facebook": facebook,
        "snapchat": snapchat,
        "tiktok": tiktok,
        "whatsapp": whatsapp,
        "instgram": instgram,
        "twitter": twitter,
        "youtube": youtube,
      };
}
