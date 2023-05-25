import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/history_ride_model.dart';
import '../../../data/repos/ride_history_repo.dart';
part 'ride_history_state.dart';

class RideHistoryCubit extends Cubit<RideHistoryState> {
  RideHistoryCubit() : super(RideHistoryInitial());
  final rideHistoryRepo = RideHistoryRepo();

  static RideHistoryCubit of(context) => BlocProvider.of(context);

  RideHistoryModel? rideHistoryModel ;
  
List<RideHistoryData> list = [];
  Future getRideHistory ()async {
    emit(RideHistoryLoading());
    final res = await rideHistoryRepo.getRideHistory();
    res.fold(
      (err) {
        showSnackBar(err);
        emit(RideHistoryInitial());
      },
      (res) async {
        log('sucsess');
        list = res.data;
        emit(RideHistoryInitial());
      },
    );
  }
}
