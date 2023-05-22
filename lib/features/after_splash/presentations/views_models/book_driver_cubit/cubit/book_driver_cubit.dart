// import 'dart:developer';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../../core/utils/app_storage.dart';
// import '../../../../../../core/utils/magic_router.dart';
// import '../../../../../../core/widgets/custom_snackbar.dart';
// import '../../../../../../translations/locale_keys.g.dart';
// import '../../../../../home/presentations/views/searching_car_view.dart';
// import '../../../../data/models/book_driver_model.dart';
// import '../../../../data/repos/book_driver_repo.dart';
// part 'book_driver_state.dart';

// class BookDriverCubit extends Cubit<BookDriverState> {
//   BookDriverCubit() : super(BookDriverInitial());

//   // double roundDouble(double value, int places){
//   //   num mod = pow(10.0, places);
//   //   return ((value * mod).round().toDouble() / mod);
//   // }
//   final bookDriverRepo = BookDriverRepo();
//   DriverData? bookRideModel;
//   static BookDriverCubit of(context) => BlocProvider.of(context);

//   Future searchDriver(

//      String startRide,
//      String endRide,
//      double currentLat,
//      double currentLong,
//       double dLat,
//       double dLong,
//      double cost,
//      String distance,
//      String time,
//       ) async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult != ConnectivityResult.mobile &&
//         connectivityResult != ConnectivityResult.wifi) {
//       showSnackBar(
//         LocaleKeys.noInternetConnectivity.tr(),
//       );
//     }
//     emit(BookDriverLoading());
//     final res = await bookDriverRepo.bookDriver( startRide, endRide, currentLat, currentLong,dLat,dLong ,cost, distance, time, );
//     res.fold(
//           (err) {
//         showSnackBar(AppStorage.getLang == 'en'
//             ? err
//             : 'Please check your data again, you have an error in the data');
//         emit(BookDriverInitial());
//       },
//           (res) async {
//            // showSnackBar(LocaleKeys.tripBookedSuccessfully.tr());
//             showSnackBar(res.message);
//             print('+++++++++++++++++++++++');
//            bookRideModel =res.data;
//            log('${bookRideModel!.id}');
//         emit(BookDriverLoading());
//        MagicRouter.navigateAndPopAll(const SearchingCarView());
//       },
//     );
//   }








// }
