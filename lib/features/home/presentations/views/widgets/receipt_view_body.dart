import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/core/widgets/custom_loading_idicator.dart';
import 'package:taxi/features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../after_splash/presentations/views/after_splash_view.dart';
import '../complaints_view.dart';
import 'bottom_sheets.dart';

class ReceiptViewBody extends StatelessWidget {
  const ReceiptViewBody({Key? key, required this.startTime, required this.endTime, required this.startTAdd, required this.endAdd, required this.cost, required this.fee, required this.total, required this.time, required this.dis,required this.late,required this.discount}) : super(key: key);
final String startTime;
   final String endTime;
   final String startTAdd;
   final String endAdd;
   final String cost;
   final String fee;
   final String total;
   final String time;
   final String dis;
   final dynamic late;
   final dynamic discount;
  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<GetDirectionCubit, GetDirectionState>(
      builder: (context, state) {
        // final getCubit = GetDirectionCubit.of(context);
        return state is GetDirectionGetRequest ? const LoadingIndicator():
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                 SizedBox(
                  height: 30.h,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Padding(
                       padding:  EdgeInsets.only(right: 18.w),
                       child: customIconBack(icon:  Icons.home,onTap: () {
                        MagicRouter.navigateAndPopAll( const AfterSplashView());
                       // destinationController.clear();
                        })
                     )
                   ],
                 ),
                  SizedBox( height: 15.h,
                ),
                              
                SizedBox(
                  width: 333.w,
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Container(
                            height: 80.w,
                            width: 80.w,
                            decoration: const BoxDecoration(
                                color: Color(0xffD5DDE0),
                                shape: BoxShape.circle),
                            child: const Center(
                                child: Icon(
                              Icons.check,
                              color: Color(0xff2C3C93),
                              size: 30,
                            )),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            LocaleKeys.yourTripHasEnded.tr(),
                            style: FontStyles.textStyle18,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            width: 303.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: kGrey2, width: .5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
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
                                           startTime .substring(0, 5),
                                            style: FontStyles.textStyle13,
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                          Text(
                                           endTime
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
                                        width: 190.w,
                                        child: SizedBox(
                                          height: 120.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                          SizedBox(
                            height: 15.h,
                          ),
                           SupTotalSection(cost: cost,dis: dis,fee: fee,time: time,total: total,late: late,discount:discount),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130.w,
                      child: CustomButton(
                        text: LocaleKeys.rate.tr(),
                        textColor: kWhite,
                        backgroundColor: kDeepBlue,
                        onPressed: (){
                          buildRateModalBottomSheet(context);
                        }
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 8.0,
                            spreadRadius: 3.0,
                            offset: Offset(0.0, 3.0),
                          )
                        ],
                      ),
                      width: 130.w,
                      child: CustomButton(
                          text: LocaleKeys.complain.tr(),
                          textColor: kBlack,
                          backgroundColor: kWhite,
                          onPressed: () =>
                              MagicRouter.navigateTo(const ComplaintsView())),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SupTotalSection extends StatelessWidget {
  const SupTotalSection({
    super.key,  this.cost,  this.fee,  this.total,  this.time,  this.dis, this.late, this.discount,
  });
  final String? cost;
   final String? fee;
   final String?total;
   final String?time;
   final String?dis;
   final dynamic late;
   final dynamic discount;
  @override
  Widget build(BuildContext context) {
    final getCubit = GetDirectionCubit.of(context);
    return Column(
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
             dis!,
              style: FontStyles.textStyle15.copyWith(color: kBlack),
            ),
             SizedBox(
              width: 2.w,
            ),
            Text(LocaleKeys.km.tr(),style: FontStyles.textStyle15.copyWith(color: kBlack),),
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
                time!,
              style: FontStyles.textStyle15.copyWith(color: kBlack),
            ),SizedBox(width: 2.w,),
             Text( LocaleKeys.mins.tr(),style: FontStyles.textStyle15.copyWith(color: kBlack),),
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
              '${(double.parse(cost!)/100).toStringAsFixed(2)} ${LocaleKeys.dinar.tr()}',
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
              '${double.parse(fee!)/100}  ${LocaleKeys.dinar.tr()}',
              style: FontStyles.textStyle15.copyWith(color: Colors.black),
            ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Text(LocaleKeys.late.tr(),
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
              Text(
                '${double.parse(late)/100}  ${LocaleKeys.dinar.tr()}',
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Text('Discount',
                style: FontStyles.textStyle15.copyWith(color: Colors.black),
              ),
              Text(
                '${((discount))} ${'%'}',
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
              '${(double.parse(total!)/100).toStringAsFixed(2)}  ${LocaleKeys.dinar.tr()}',
              style: FontStyles.textStyle15
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}
