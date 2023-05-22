// To parse this JSON data, do
//
//     final bookRideModel = bookRideModelFromJson(jsonString);

import 'dart:convert';

BookRideModel bookRideModelFromJson(String str) => BookRideModel.fromJson(json.decode(str));

String bookRideModelToJson(BookRideModel data) => json.encode(data.toJson());

class BookRideModel {
    BookRideModel({
        required this.status,
        required this.message,
        required this.data,
    });

    String status;
    String message;
    Data data;

    factory BookRideModel.fromJson(Map<String, dynamic> json) => BookRideModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.date,
        required this.time,
        required this.startRide,
        required this.endRide,
    });

    int id;
    DateTime date;
    dynamic time;
    String startRide;
    String endRide;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        startRide: json["start_ride"],
        endRide: json["end_ride"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "start_ride": startRide,
        "end_ride": endRide,
    };
}
