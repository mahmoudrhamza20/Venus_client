import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/get_driver_model.dart';
import '../../../data/repos/get_driver_ropo.dart';
part 'get_driver_state.dart';


class GetDriverCubit extends Cubit<GetDriverState> {
  GetDriverCubit() : super(GetDriverInitial());

  final getDriverRepo = GetDriverRepo();

  static GetDriverCubit of(context) => BlocProvider.of(context);
  GetDriverData? getDriverData;

  Future getDriverDetails(int rideId) async {
    emit(GetDriverLoading());
    final res = await getDriverRepo.getDriverDetailsRepo(rideId);
  
    res.fold(
          (err) {
        showSnackBar(err.toString());
        emit(GetDriverInitial());
      },
          (res) async {
            getDriverData = res.data;
            log('11111111111111111111111111111111111111');
            log(res.data.name);
            log(res.data.carType);
            log('11111111111111111111111111111111111111');
        emit(GetDriverDone());
      },
    );
  }



}
