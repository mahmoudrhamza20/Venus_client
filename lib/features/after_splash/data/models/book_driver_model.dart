// // To parse this JSON data, do
// //
// //     final bookRideModel = bookRideModelFromJson(jsonString);

// import 'dart:convert';

// BookDriverModel bookRideModelFromJson(String str) => BookDriverModel.fromJson(json.decode(str));

// String bookRideModelToJson(BookDriverModel data) => json.encode(data.toJson());

// class BookDriverModel {
//     BookDriverModel({
//         required this.status,
//         required this.message,
//         required this.data,
//     });

//     String status;
//     String message;
//     DriverData data;

//     factory BookDriverModel.fromJson(Map<String, dynamic> json) => BookDriverModel(
//         status: json["status"],
//         message: json["message"],
//         data: DriverData.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class DriverData {
//     DriverData({
//         required this.id,
//         required this.date,
//         required this.time,
//         required this.startRide,
//         required this.endRide,
//     });

//     int id;
//     DateTime date;
//     String time;
//     String startRide;
//     String endRide;

//     factory DriverData.fromJson(Map<String, dynamic> json) => DriverData(
//         id: json["id"],
//         date: DateTime.parse(json["date"]),
//         time: json["time"],
//         startRide: json["start_ride"],
//         endRide: json["end_ride"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "time": time,
//         "start_ride": startRide,
//         "end_ride": endRide,
//     };
// }
