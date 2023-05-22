import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/features/auth/presentation/views_models/phone_auth/phone_auth_cubit.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_icon_back.dart';
import '../../../../translations/locale_keys.g.dart';

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({Key? key}) : super(key: key);

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(30),
      //border: Border.all(color: Colors.grey),
    ),
  );

  int timeLeft = 0;

  void _startCountDown() {
    timeLeft = 30;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
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
                      // height: 130.h,
                      height: 20.h,
                    ),
                    Image.asset(AssetsData.logo),
                    SizedBox(
                      height: 27.h,
                    ),
                    Column(
                      children: [
                        Text(
                          'A code has been sent to  ',
                          style: FontStyles.textStyle15,
                        ),
                        Text(
                          ' +33 234 556 7888 via SMS ',
                          style: FontStyles.textStyle15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPinCode(defaultPinTheme: defaultPinTheme),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    timeLeft == 0
                        ? InkWell(
                            onTap: _startCountDown,
                            child: Text(LocaleKeys.resendCode.tr(),
                                style: FontStyles.textStyle13.copyWith(
                                  decoration: TextDecoration.underline,
                                )))
                        : Text(
                            "${LocaleKeys.resendCode.tr()} ( 0:${timeLeft.toString()} )",
                            style: FontStyles.textStyle13.copyWith(
                              decoration: TextDecoration.underline,
                            )),
                    // SizedBox(height: MediaQuery.of(context).size.height*.18,),
                    // CustomButton(text: 'Reset Password',
                    //     textColor: Colors.white,
                    //     borderRadius: BorderRadius.circular(25),
                    //     backgroundColor: kDeepBlue.withOpacity(.9),
                    //     onPressed: () {
                    //       navigateTo(context, AppRouter.kResetPassView);
                    //     }
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomPinCode extends StatelessWidget {
  const CustomPinCode({
    super.key,
    required this.defaultPinTheme,
  });

  final PinTheme defaultPinTheme;

  @override
  Widget build(BuildContext context) {
    final cubit = PhoneAuthCubit.of(context);
    return SizedBox(
      width: 300.w,
      height: 100.h,
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(color: kDeepBlue),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: kDeepBlue),
          ),
        ),
        // validator: (s) {
        //   s == '222222'
        //       ? MagicRouter.navigateTo(const ResetPasswordView())
        //       : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //           backgroundColor: kDeepBlue,
        //           content: Text(
        //             LocaleKeys.pinCodeIncorrect.tr(),
        //             textAlign: TextAlign.center,
        //             style: const TextStyle(fontSize: 15),
        //           ),
        //         ));
        // },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) {
          cubit.submitOTP(pin);
        },
      ),
    );
  }
}
