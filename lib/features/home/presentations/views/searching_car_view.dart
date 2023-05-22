import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/features/home/presentations/views/widgets/bottom_sheets.dart';
import 'package:taxi/features/home/presentations/views_models/cancel_search_cubit/cancelled_search_cubit.dart';
import 'package:taxi/features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../views_models/get_driver_cubit/get_driver_cubit.dart';
import '../views_models/post_details_cubit/post_details_cubit.dart';


class SearchingCarView extends StatefulWidget {
  const SearchingCarView({super.key});

  @override
  State<SearchingCarView> createState() => _SearchingCarViewState();
}


class _SearchingCarViewState extends State<SearchingCarView> {


  @override
  void initState() {
    super.initState();
GetDriverCubit.of(context).getDriverDetails(PostDetailsCubit.of(context).bookRideModel!.id);
GetDirectionCubit.of(context).getRequest();
//GetDirectionCubit.of(context).driverArrived();
// GetDirectionCubit.of(context).notificationDetails!.lat;
// GetDirectionCubit.of(context).notificationDetails!.lng;
    // Timer(const Duration(seconds: 6), () =>
    //     MagicRouter.navigateTo(const TrackerMapView()),);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = CancelledSearchCubit.of(context);
   // final getCubit = GetDirectionCubit.of(context);
   final postCubit = PostDetailsCubit.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarGlow(
              glowColor: Colors.grey,
              endRadius: 120,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              curve: Curves.easeOutQuad,
              child: Container(
                  height: 80.w,
                  width: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99.r)),
                  child: Image.asset(AssetsData.carTop)
              ),
            ),
            SizedBox(height: 50.h,),
            Text(LocaleKeys.searchingForDriver.tr(),
              style: FontStyles.textStyle25.copyWith(color: kDeepBlue),),
            SizedBox(height: 20.h,),
            BlocListener<GetDirectionCubit, GetDirectionState>(
              listener: (context, state) {},
              child: CustomButton(
                text: LocaleKeys.cancel.tr(),
                textColor: kWhite,
                backgroundColor: kDeepBlue,
                onPressed: () =>
                    buildShowModalBottomSheet(
                        context,
                        title: LocaleKeys.areYouSureYouWantToCancelSearching
                            .tr(),
                        leftBtnText: LocaleKeys.no.tr(),
                        rightBtnText: LocaleKeys.yes.tr(),
                        rightBtnFunc: () {
                         cubit.cancelRide(postCubit.bookRideModel!.id);
                        //  GetDriverCubit.of(context).getDriversDetails(PostDetailsCubit.of(context).bookRideModel!.id);
                        }
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}