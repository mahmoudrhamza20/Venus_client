import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/history_ride_details_model.dart';
import '../../../data/repos/ride_history_details_repo.dart';
import '../../views/ride_story_item_details_view.dart';
part 'histoty_ride_details_state.dart';


class HistotyRideDetailsCubit extends Cubit<HistotyRideDetailsState> {
  HistotyRideDetailsCubit() : super(HistotyRideDetailsInitial());

  final historyRideDetailsRepo = HistoryRideDetailsRepo();

  static HistotyRideDetailsCubit of(context) => BlocProvider.of(context);
  HistotyRideDetails? histotyRideDetailsData;

  Future getHistotyRideDetails(int rideId) async {
    emit(HistotyRideDetailsLoading());
    final res = await historyRideDetailsRepo.getHistoryRideDetails(rideId);
    res.fold(
          (err) {
        showSnackBar(err);
        emit(HistotyRideDetailsInitial());
      },
          (res) async {
            histotyRideDetailsData = res.data;
            print('11111111111111111111111111111111111111');
            print(histotyRideDetailsData!.driver.name);
            print(histotyRideDetailsData!.late);
            print('11111111111111111111111111111111111111');
            MagicRouter.navigateTo( RideStoryItemDetailsView(
              cost: histotyRideDetailsData!.costRide,
               dis: histotyRideDetailsData!.distance ,
               time: histotyRideDetailsData!.time.toString(),
                startTime: histotyRideDetailsData!.startTime,
                 total: histotyRideDetailsData!.total,
                  startTAdd: histotyRideDetailsData!.startRide,
                   type:histotyRideDetailsData!.driver.type,
                   rate: histotyRideDetailsData!.driver.avgRate.toString(),
                    photo: histotyRideDetailsData!.driver.photo,
                     name: histotyRideDetailsData!.driver.name,
                      fee: histotyRideDetailsData!.fee,
                       endTime: histotyRideDetailsData!.endTime, 
                       endAdd: histotyRideDetailsData!.endRide,
                       late: histotyRideDetailsData!.late,
                       discount: histotyRideDetailsData!.discount,


            )
            );
        emit(HistotyRideDetailsInitial());
      },
    );
  }



}
