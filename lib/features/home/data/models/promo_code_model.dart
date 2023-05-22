// To parse this JSON data, do
//
//     final promoCodeModel = promoCodeModelFromJson(jsonString);

import 'dart:convert';

PromoCodeModel promoCodeModelFromJson(String str) => PromoCodeModel.fromJson(json.decode(str));

String promoCodeModelToJson(PromoCodeModel data) => json.encode(data.toJson());

class PromoCodeModel {
    bool status;
    Coupon coupon;
    String message;

    PromoCodeModel({
        required this.status,
        required this.coupon,
        required this.message,
    });

    factory PromoCodeModel.fromJson(Map<String, dynamic> json) => PromoCodeModel(
        status: json["status"],
        coupon: Coupon.fromJson(json["coupon"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "coupon": coupon.toJson(),
        "message": message,
    };
}

class Coupon {
    int id;
    String coupon;
    dynamic value;
    String maxInvoices;
    String maxToOneClient;
    DateTime maxDate;
    int status;
    String message;

    Coupon({
        required this.id,
        required this.coupon,
        required this.value,
        required this.maxInvoices,
        required this.maxToOneClient,
        required this.maxDate,
        required this.status,
        required this.message,
    });

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        coupon: json["coupon"],
        value: json["value"],
        maxInvoices: json["max_invoices"],
        maxToOneClient: json["max_to_one_client"],
        maxDate: DateTime.parse(json["max_date"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coupon": coupon,
        "value": value,
        "max_invoices": maxInvoices,
        "max_to_one_client": maxToOneClient,
        "max_date": "${maxDate.year.toString().padLeft(4, '0')}-${maxDate.month.toString().padLeft(2, '0')}-${maxDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "message": message,
    };
}
