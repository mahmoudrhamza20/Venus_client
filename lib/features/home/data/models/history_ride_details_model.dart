// To parse this JSON data, do
//
//     final histotyRideDetailsModel = histotyRideDetailsModelFromJson(jsonString);

import 'dart:convert';

HistotyRideDetailsModel histotyRideDetailsModelFromJson(String str) => HistotyRideDetailsModel.fromJson(json.decode(str));

String histotyRideDetailsModelToJson(HistotyRideDetailsModel data) => json.encode(data.toJson());

class HistotyRideDetailsModel {
    String status;
    String message;
    HistotyRideDetails data;

    HistotyRideDetailsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory HistotyRideDetailsModel.fromJson(Map<String, dynamic> json) => HistotyRideDetailsModel(
        status: json["status"],
        message: json["message"],
        data: HistotyRideDetails.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class HistotyRideDetails {
    int id;
    int driverId;
    dynamic fee;
    String startRide;
    String endRide;
    dynamic cost;
    dynamic costRide;
    dynamic late;
    String startTime;
    String endTime;
    String distance;
    String time;
    dynamic total;
    dynamic discount;
    Driver driver;
    DateTime date;
    dynamic reasonCancelled;
    dynamic responsible;

    HistotyRideDetails({
        required this.id,
        required this.driverId,
        required this.fee,
        required this.startRide,
        required this.endRide,
        required this.cost,
        required this.costRide,
        required this.late,
        required this.startTime,
        required this.endTime,
        required this.distance,
        required this.time,
        required this.total,
        required this.discount,
        required this.driver,
        required this.date,
        this.reasonCancelled,
        this.responsible,
    });

    factory HistotyRideDetails.fromJson(Map<String, dynamic> json) => HistotyRideDetails(
        id: json["id"],
        driverId: json["driverId"],
        fee: json["fee"],
        startRide: json["startRide"],
        endRide: json["endRide"],
        cost: json["cost"],
        costRide: json["cost_ride"],
        late: json["late"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        distance: json["distance"],
        time: json["Time"],
        total: json["Total"],
        discount: json["discount"],
        driver: Driver.fromJson(json["driver"]),
        date: DateTime.parse(json["date"]),
        reasonCancelled: json["reason_cancelled"],
        responsible: json["responsible"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "driverId": driverId,
        "fee": fee,
        "startRide": startRide,
        "endRide": endRide,
        "cost": cost,
        "cost_ride": costRide,
        "late": late,
        "startTime": startTime,
        "endTime": endTime,
        "distance": distance,
        "Time": time,
        "Total": total,
        "driver": driver.toJson(),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "reason_cancelled": reasonCancelled,
        "responsible": responsible,
    };
}

class Driver {
    String name;
    String userName;
    String phone;
    String photo;
    dynamic avgRate;
    String license;
    int board;
    String type;

    Driver({
        required this.name,
        required this.userName,
        required this.phone,
        required this.photo,
        required this.avgRate,
        required this.license,
        required this.board,
        required this.type,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        name: json["name"],
        userName: json["userName"],
        phone: json["phone"],
        photo: json["photo"],
        avgRate: json["avgRate"],
        license: json["license"],
        board: json["board"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "userName": userName,
        "phone": phone,
        "photo": photo,
        "avgRate": avgRate,
        "license": license,
        "board": board,
        "type": type,
    };
}
