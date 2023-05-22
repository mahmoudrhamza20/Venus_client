import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';
import 'package:taxi/global_variables.dart';
import '../../../../core/widgets/progress_dialog.dart';
import '../../../../translations/locale_keys.g.dart';
import '../views_models/cancel_ride_cubit/cancelled_ride_cubit.dart';
import '../views_models/post_details_cubit/post_details_cubit.dart';

class CancelingReasonsView extends StatelessWidget {
  const CancelingReasonsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (context) => CancelledRideCubit(),
        child: const CancelingReasonsViewBody(),
      )),
    );
  }
}

class CancelingReasonsViewBody extends StatefulWidget {
  const CancelingReasonsViewBody({Key? key}) : super(key: key);

  @override
  State<CancelingReasonsViewBody> createState() =>
      _CancelingReasonsViewBodyState();
}

class _CancelingReasonsViewBodyState extends State<CancelingReasonsViewBody> {
  String radioItem = LocaleKeys.idontWantToShare.tr();

  // Group Value for Radio Button.
  int id = 1;
  List<ReasonsModel> reasons = [
    ReasonsModel(
      index: 1,
      name: LocaleKeys.idontWantToShare.tr(),
    ),
    ReasonsModel(
      index: 2,
      name: LocaleKeys.cantContactTheDriver.tr(),
    ),
    ReasonsModel(
      index: 3,
      name: LocaleKeys.driverIsLate.tr(),
    ),
    ReasonsModel(
      index: 4,
      name: LocaleKeys.thePriceIsNotReasonable.tr(),
    ),
    ReasonsModel(
      index: 5,
      name: LocaleKeys.pickupAddressAsIncorrect.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final postCubit = PostDetailsCubit.of(context);
    final getCubit = GetDirectionCubit.of(context);
    final cancelCubit = CancelledRideCubit.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          Text(
            LocaleKeys.pleaseSelectTheReasonForCrancellation.tr(),
            style: FontStyles.textStyle20,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 300.h,
            child: Column(
              children: reasons
                  .map((data) => RadioListTile(
                        activeColor: const Color(0xff2C3C93),
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          data.name,
                          style: FontStyles.textStyle15.copyWith(color: kBlack),
                        ),
                        groupValue: id,
                        value: data.index,
                        onChanged: (val) {
                          setState(() {
                            radioItem = data.name;
                            id = data.index;
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          BlocBuilder<CancelledRideCubit, CancelledRideState>(
            builder: (context, state) {
              return   state is CancelledRideLoading
                  ? Center(
                    child: ProgressDialog(status: LocaleKeys.loggingYouIn.tr()),)
                  : Center(
                    child: CustomButton(
                    text: LocaleKeys.submit.tr(),
                    textColor: kWhite,
                    backgroundColor: kDeepBlue,
                    onPressed: () => {
                      print(radioItem),
                      cancelCubit.cancelRide( rideId:postCubit.bookRideModel!.id ,reason: 'client_$radioItem'),
                      print(getCubit.notificationDetails!.ride),
                    }
                    
                    ),
                  );
            },
          )
        ],
      ),
    );
  }
}

class ReasonsModel {
  String name;
  int index;

  ReasonsModel({required this.name, required this.index});
}
