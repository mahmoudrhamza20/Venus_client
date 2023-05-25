import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/features/home/presentations/views_models/hisroty_ride_details_cubit/histoty_ride_details_cubit.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_loading_idicator.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../views_models/get_direction_cubit/get_direction_cubit.dart';
import '../support_view.dart';

class RideStoryItemDetailsViewBody extends StatelessWidget {
  const RideStoryItemDetailsViewBody({Key? key, required this.endTime, required this.startTime, required this.startTAdd, required this.endAdd, required this.cost, required this.fee, required this.total, required this.time, required this.dis, required this.photo, required this.name, required this.type, required this.rate,required this.late,required this.discount, }) : super(key: key);

final String endTime;
 final String startTime;
   final String startTAdd;
   final String endAdd;
   final dynamic cost;
   final dynamic fee;
   final dynamic total;
   final String time;
   final String dis;
   final String photo;
   final String name;
   final String type;
   final dynamic rate;
   final dynamic late;
   final String discount;

  @override
  Widget build(BuildContext context) {
    return 
        BlocBuilder<HistotyRideDetailsCubit,HistotyRideDetailsState>(
          builder: (BuildContext context, state) { 
            return  state is HistotyRideDetailsLoading
            ? const LoadingIndicator()
            : SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          customIconBack(
                              icon:
                                  Localizations.localeOf(context).languageCode ==
                                          'en'
                                      ? Icons.keyboard_arrow_left
                                      : Icons.keyboard_arrow_right,
                              onTap: () => MagicRouter.pop()),
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.center,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 300.h,
                            child: Image.asset(AssetsData.map)),
                        Image.asset(AssetsData.polyline),
                        Positioned(
                          bottom: -70.h,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              height: 150.h,
                              child: Card(
                                elevation: 4,
                                shadowColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                startTime
                                                    .substring(0, 5),
                                                style: FontStyles.textStyle13,
                                              ),
                                              SizedBox(
                                                height: 50.h,
                                              ),
                                              Text(
                                               endTime .substring(0, 5)
                                                    ,
                                                style: FontStyles.textStyle13,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: kDeepBlue,
                                                size: 16.w,
                                              ),
                                              Container(
                                                width: 1.2.w,
                                                height: 50.h,
                                                color: const Color(0xff3E4958),
                                              ),
                                              const Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xff4B545A),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 225.w,
                                            child: SizedBox(
                                              height: 115.h,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                   startTAdd,
                                                    maxLines: 2,
                                                    style: FontStyles.textStyle15
                                                        .copyWith(
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            color: kBlack),
                                                  ),
                                                  Text(
                                                  endAdd,
                                                    maxLines: 2,
                                                    style: FontStyles.textStyle15
                                                        .copyWith(
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            color: kBlack),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 75.h,
                    ),
                    SizedBox(
                      height: 120.h,
                      child: BlocListener<GetDirectionCubit, GetDirectionState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w),
                          child: Card(
                            elevation: 4,
                            shadowColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  photo == null
                                      ? Container(
                                          width: 80.w,
                                          height: 80.w,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              'assets/images/user.png'))
                                      : Container(
                                          width: 80.w,
                                          height: 80.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(photo),
                                            ),
                                          )),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: FontStyles.textStyle18,
                                      ),
                                      Text(
                                       type,
                                        style: FontStyles.textStyle15
                                            .copyWith(color: kBlack),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(AssetsData.star),
                                          Text(
                                            (rate)
                                                .toString(),
                                            style: FontStyles.textStyle15,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: 32.w),
                       child:  Column(
              children: [
          const Divider(
            thickness: 1.5,
            color: Color(0xffD5DDE0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.youTravelled.tr(),
                style: FontStyles.textStyle15.copyWith(color: kBlack),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
               dis,
                style: FontStyles.textStyle15.copyWith(color: kBlack),
              ),
               SizedBox(
                width: 2.w,
              ),
              Text(
                LocaleKeys.km.tr(),
                style: FontStyles.textStyle15.copyWith(color: kBlack),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                LocaleKeys.inx.tr(),
                style: FontStyles.textStyle15.copyWith(color: kBlack),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                time,
                style: FontStyles.textStyle15.copyWith(color: kBlack),
              ),
               SizedBox(
                width: 2.w,
              ),
              Text(
                LocaleKeys.mins.tr(),
                style: FontStyles.textStyle15.copyWith(color: kBlack),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.tripFare.tr(),
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
              Text(
                '${cost/100}  ${LocaleKeys.dinar.tr()}',
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.previousCancelFees.tr(),
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
              Text(
                '${fee/100}  ${LocaleKeys.dinar.tr()}',
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                   Text(
               LocaleKeys.late.tr(),
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
              Text(
                '${late/100} ${LocaleKeys.dinar.tr()}',
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Text( LocaleKeys.discount.tr(),
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
              Text(
                '${double.parse(discount)/100 }' ,
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
            ],
          ),
          const Divider(
            thickness: 1.5,
            color: Color(0xffD5DDE0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.subTotal.tr(),
                style: FontStyles.textStyle15
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Text(
                '${total/100}  ${LocaleKeys.dinar.tr()}',
                style: FontStyles.textStyle15
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
              ],
            )
                     ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: CustomButton(
                      text: LocaleKeys.raiseissue.tr(),
                      textColor: kWhite,
                      backgroundColor: kDeepBlue,
                      onPressed: () =>
                          MagicRouter.navigateTo(const RaiseIssueView()),
                    )),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          );
           },
          
        );
      }
}
