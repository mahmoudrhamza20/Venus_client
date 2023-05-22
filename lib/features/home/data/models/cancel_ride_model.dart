// To parse this JSON data, do
//
//     final cancelRideModel = cancelRideModelFromJson(jsonString);

import 'dart:convert';

CancelRideModel cancelRideModelFromJson(String str) => CancelRideModel.fromJson(json.decode(str));

String cancelRideModelToJson(CancelRideModel data) => json.encode(data.toJson());

class CancelRideModel {
    Data data;
    Ride ride;

    CancelRideModel({
        required this.data,
        required this.ride,
    });

    factory CancelRideModel.fromJson(Map<String, dynamic> json) => CancelRideModel(
        data: Data.fromJson(json["data"]),
        ride: Ride.fromJson(json["Ride"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "Ride": ride.toJson(),
    };
}

class Data {
    String status;
    String message;

    Data({
        required this.status,
        required this.message,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}

class Ride {
    int id;
    DateTime date;
    String time;
    String startRide;
    String endRide;

    Ride({
        required this.id,
        required this.date,
        required this.time,
        required this.startRide,
        required this.endRide,
    });

    factory Ride.fromJson(Map<String, dynamic> json) => Ride(
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
