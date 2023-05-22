
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../views_models/hisroty_ride_details_cubit/histoty_ride_details_cubit.dart';
import '../ride_story_item_details_view.dart';

class RideStoryItem extends StatelessWidget {
  const RideStoryItem({
    super.key, required this.date, required this.startTime, required this.endTiem, required this.startLocation, required this.endLocation, required this.status, required this.rideId,
  });

final String date;
final String startTime;
final String endTiem;
final String startLocation;
final String endLocation;
final String status;
final int rideId;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date,style: FontStyles.textStyle13.copyWith(fontWeight: FontWeight.w700,color: kBlack),),
                Text(status =='Status.DONE' ? ' ': LocaleKeys.cancelled.tr()
               ,
                style: FontStyles.textStyle13.copyWith(fontWeight: FontWeight.w700,color: Colors.redAccent),
                  ),
              ],
            ),
            const Divider(
              color: Color(0xffD5DDE0),
              thickness: .6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(startTime.substring(0,5),style: FontStyles.textStyle13,),
                    SizedBox(height: 50.h,),
                    Text(endTiem.substring(0,5),style: FontStyles.textStyle13,),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.circle,color: kDeepBlue,size: 16.w,),
                    Container(
                      width: 1.2.w,
                      height: 50.h,
                      color: const Color(0xff3E4958),
                    ),
                    const Icon(Icons.arrow_drop_down,color: Color(0xff4B545A),)
                  ],
                ),
                SizedBox(
                  width: 225.w,
                  child: SizedBox(
                    height: 115.h,
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(startLocation,maxLines: 2,style: FontStyles.textStyle15.copyWith(overflow: TextOverflow.ellipsis,color: kBlack),),
                        Text(endLocation,maxLines: 2,style: FontStyles.textStyle15.copyWith(overflow: TextOverflow.ellipsis,color: kBlack),),
                      ],
                    ),
                  ),
                ),
              ],)
          ],
        ),
      ),
    );
  }
}