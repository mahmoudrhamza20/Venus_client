import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi/core/widgets/custom_loading_idicator.dart';
import 'package:taxi/features/home/presentations/views/widgets/ride_story_item.dart';
import 'package:taxi/features/home/presentations/views_models/ride_history_cubit/ride_history_cubit.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../views_models/hisroty_ride_details_cubit/histoty_ride_details_cubit.dart';

class RideStoryViewBody extends StatelessWidget {
  const RideStoryViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RideHistoryCubit, RideHistoryState>(
      builder: (context, state) {
        final cubit = RideHistoryCubit.of(context);
        return state is RideHistoryLoading?const LoadingIndicator()
        :
        
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      customIconBack(
                          icon: Localizations.localeOf(context).languageCode ==
                                  'en'
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_left,
                          onTap: () => MagicRouter.pop()),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  cubit.list.isEmpty?  Center(
        child:SizedBox(
          height: 250.h,
          width: 250.w,
          child: Lottie.asset('assets/json/manwaitingcar.json')),
        ):
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:  cubit.list.length,
                      itemBuilder: (context, index) =>  InkWell(
                      
                        onTap: ()=>HistotyRideDetailsCubit.of(context).getHistotyRideDetails( cubit.list[index].id,),
                        child: RideStoryItem(
                        date: cubit.list[index].date.toString().split(' ')[0],
                        startTime: cubit.list[index].startTime!.toString(),
                        endLocation: cubit.list[index].endRide.toString(),
                        startLocation: cubit.list[index].startRide.toString(),
                        endTiem: cubit.list[index].endTime!.toString(),
                        status: cubit.list[index].status.toString(), 
                        rideId: cubit.list[index].id,
                        ),
                         
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
