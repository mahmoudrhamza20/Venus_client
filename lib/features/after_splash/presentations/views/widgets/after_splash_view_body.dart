import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/features/home/presentations/views/home_view.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../global_variables.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';
import '../../../../home/presentations/views_models/post_details_cubit/post_details_cubit.dart';
import 'dart:developer';

class AfterSplashViewBody extends StatefulWidget {
  const AfterSplashViewBody({super.key});

  @override
  State<AfterSplashViewBody> createState() => _AfterSplashViewBodyState();
}

class _AfterSplashViewBodyState extends State<AfterSplashViewBody> {
  Future<void> refreshData() async {
    setState(() {});
  }
  
  void getCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        showSnackBar('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
  } 
  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final postCubit = PostDetailsCubit.of(context);
    final getDirectionCubit = GetDirectionCubit.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.h, right: 13.w),
                child: Builder(builder: (context) {
                  return customIconBack(
                    icon: Icons.menu,
                    onTap: () async {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(child: Image.asset(AssetsData.logo)),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChooseCard(
                      icon: Icons.location_on,
                      text: LocaleKeys.setDestination.tr(),
                      onTap: () {
                         MagicRouter.navigateTo(const HomeView());
                         }),
                  BlocListener<PostDetailsCubit, PostDetailsState>(
                    listener: (context, state) {
                    },
                    child: ChooseCard(
                      icon: Icons.location_off,
                      text: LocaleKeys.withoutDestination.tr(),
                      onTap: () {
                postCubit.postData(
                  startRide:'Current Location',
                  currentLat:currentPosition.latitude,
                  currentLong:currentPosition.longitude,
                  cost:0,
                  );
                  getDirectionCubit.driverArrived();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 350.h,
                  width: 350.w,
                  child: Lottie.asset('assets/json/manwaitingcar.json')),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseCard extends StatelessWidget {
  const ChooseCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 160.w,
        height: 150.h,
        child: Card(
          elevation: 4,
          shadowColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: kDeepBlue,
                ),
                Text(
                  text,
                  style: FontStyles.textStyle15
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
