import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_storage.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../global_variables.dart';
import '../../../data/models/direction_details_model.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../data/models/book_ride_model.dart';
import '../../../data/repos/post_details_repo.dart';
import '../../views/searching_car_view.dart';
part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit() : super(PostDetailsInitial());


  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

   double estimateFares(DirectionDetails details) {
    // per KM = $.2,
    // per min = $0.5,
    // base fare = $1

    double baseFare = 1;
    double distanceFare = (details.distanceValue! / 1000) * .2;
   // double timeFare = (details.durationValue! / 60) * 0.5;

    double totalFare = baseFare + distanceFare ;
    return roundDouble( totalFare,2);
  }


  final postDetailsRepo = PostDetailsRepo();
  Data? bookRideModel;
  static PostDetailsCubit of(context) => BlocProvider.of(context);

  Future postData(
    { String? startRide,
     String ?endRide,
     double? currentLat,
     double? currentLong,
      double? dLat,
      double? dLong,
     double? cost,
     String? distance,
     String ?time,
     int? coupunId,
     }
     // String endTime,
      ) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(
        LocaleKeys.noInternetConnectivity.tr(),
      );
    }
    emit(PostDetailsLoading());
    final res = await postDetailsRepo.postDetails(
      startRide:  startRide,endRide:endRide,currentLat: currentLat,currentLong: currentLong,dLat:dLong ,cost:cost,distance: distance,time: time,coupunId:coupunId );
    res.fold(
          (err) {
        showSnackBar(AppStorage.getLang == 'en'
            ? err
            : 'Please check your data again, you have an error in the data');
        emit(PostDetailsInitial());
      },
          (res) async {
            showSnackBar(res.message);
           // showSnackBar(LocaleKeys.tripBookedSuccessfully.tr());
           // showSnackBar(AppStorage.getLang == 'en'?'Trip Booked Successfully ':'تم حجز الرحله بنجاح');
            print('+++++++++++++++++++++++');
           bookRideModel =res.data;
           rideIdCancel = bookRideModel!.id;
           print(bookRideModel!.id);
        emit(PostDetailsLoading());
       MagicRouter.navigateAndPopAll(const SearchingCarView());
      },
    );
  }



}
