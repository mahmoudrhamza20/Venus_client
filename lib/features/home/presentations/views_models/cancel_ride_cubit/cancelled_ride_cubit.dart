import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/features/after_splash/presentations/views/after_splash_view.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../unsupported_location/presentations/views/unsupported_ location_view.dart';
import '../../../data/repos/cancelled_ride_repo.dart';
part 'cancelled_ride_state.dart';

class CancelledRideCubit extends Cubit<CancelledRideState> {
  CancelledRideCubit() : super(CancelledRideInitial());

  static CancelledRideCubit of(context) => BlocProvider.of(context);

  final cancelRideRepo = CancelledRideRepo();
  Future cancelRide({required String reason, required int rideId}) async {
    emit(CancelledRideInitial());
    final res = await cancelRideRepo.cancelRide( reason:reason ,rideId:rideId );
    res.fold(
          (err) {
        showSnackBar(err.toString());
        print('error');
        emit(CancelledRideLoading());
       
          },
          (res) async {
            //showSnackBar(res.message.message);
           showSnackBar( CacheHelper.getData(key: 'lang') !='en'
                  ? res.data.message:'Ride is cancelled');
        emit(CancelledRideInitial());
        print('sucess Cancelled');
        MagicRouter.navigateAndPopAll(const AfterSplashView());

      },
    );
  }
}
