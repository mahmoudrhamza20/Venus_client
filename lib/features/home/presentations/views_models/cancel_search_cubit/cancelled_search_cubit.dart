import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../after_splash/presentations/views/after_splash_view.dart';
import '../../../../unsupported_location/presentations/views/unsupported_ location_view.dart';
import '../../../data/repos/cancelled_search_repo.dart';
part 'cancelled_search_state.dart';

class CancelledSearchCubit extends Cubit<CancelledSearchState> {
  CancelledSearchCubit() : super(CancelledSearchInitial());

   static CancelledSearchCubit of(context) => BlocProvider.of(context);

  final cancelledSearchRepo = CancelledSearchRepo();
  Future cancelRide(int rideId) async {
    emit(CancelledSearchInitial());
    final res = await cancelledSearchRepo.cancelSearch(rideId);
    res.fold(
          (err) {
        showSnackBar(err.toString());
        print('error');
        emit(CancelledSearchLoading());
        MagicRouter.navigateAndPopAll(const UnsupportedLocationView());
      },
          (res) async {
        emit(CancelledSearchSuc());
        showSnackBar( CacheHelper.getData(key: 'lang') !='en'
                  ?res.message:'Search is Cancelled');
        print('sucess');
        
        MagicRouter.navigateAndPopAll(const AfterSplashView());
      },
    );
  }
}
