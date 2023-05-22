// // ignore_for_file: avoid_print
// import 'dart:convert';
// import 'dart:developer';
// import 'package:dartz/dartz.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:taxi/core/utils/app_storage.dart';
// import '../../../../core/utils/cache_helper.dart';
// import '../../../../core/utils/dio_helper.dart';
// import '../../../../core/utils/end_points.dart';
// import '../../../../core/utils/error_model.dart';
// import '../../../home/data/models/book_ride_model.dart';
// import '../models/book_driver_model.dart';
// // String dateTime(hour){
// //   dynamic h=  hour*60;
// //   return  h.toString() ;
// // }

// class BookDriverRepo {
//   BookRideModel? bookRideModel;
//   Future<Either<String, BookDriverModel>> bookDriver(
//      String startRide,
//      String endRide,
//      double currentLat,
//      double currentLong,
//      double dLat,
//      double dLong,
//      double cost,
//      String distance,
//      String time,

//       ) async {
//     final response = await DioHelper.post(EndPoints.calculateRide,
//        body: {
//          'start_ride': startRide,
//          'end_ride': endRide,
//          'time':time,
//          'start_time':DateFormat.jm('en_US').format(DateTime.now()).substring(0,5),
//          'distance' :distance,
//          'cost':cost,
//          'lat': currentLat,
//          'lng': currentLong,
//     }, headers: {
//           'client': CacheHelper.getData(key: 'userId'),
//           'lang': AppStorage.getLang,
//           'dlat':dLat,
//           'dlng':dLong,
//         });
//         log(DateFormat.jm('en_US').format(DateTime.now()).substring(0,5));
     
//      try {
//       if (response.statusCode == 200)  {
//        print("Success BookDriverRepo");
//         print('////////////////');
//         print(response);
//         print('////////////////');
//         return Right(BookDriverModel.fromJson(jsonDecode(response.toString())));
//       } else {
//         print(response);
//         return Left(ErrorModel.fromJson(jsonDecode(response.toString()))
//             .message
//             .toString());
//       }
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }
