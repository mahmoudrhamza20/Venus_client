import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/features/auth/presentation/views/widgets/media_login_button.dart';
import 'package:taxi/features/auth/presentation/views/widgets/or_divider.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../core/widgets/progress_dialog.dart';
import '../../../../../global_variables.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../views_models/login_cubit/login_cubit.dart';
import '../forget_password_view.dart';
import '../register_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: LoginCubit.of(context).formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: customIconBack(
                      icon: Icons.language,
                      onTap: () {
                        if (LoginCubit.of(context).localeIsEn == true) {
                          context.setLocale(const Locale('en'));
                        } else {
                          context.setLocale(const Locale('ar'));
                        }
                        LoginCubit.of(context).localeIsEn =
                            !LoginCubit.of(context).localeIsEn;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Image(
                      image: const AssetImage(AssetsData.logo),
                      alignment: Alignment.center,
                      height: 105.h,
                      width: 267.w,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.phoneNumber.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                        customTextField(
                            prefix: const Icon(Icons.mail),
                            controller: LoginCubit.of(context).emailController,
                            isPassword: false,
                            type: TextInputType.emailAddress),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          LocaleKeys.password.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                        customTextField(
                            prefix: const Icon(Icons.lock),
                            controller:
                                LoginCubit.of(context).passwordController,
                            isPassword:
                                LoginCubit.of(context).showPassword == true
                                    ? true
                                    : false,
                            type: TextInputType.visiblePassword,
                            onPressed: () {
                              setState(() {
                                LoginCubit.of(context).showPassword =
                                    !LoginCubit.of(context).showPassword;
                              });
                            },
                            endIcon: LoginCubit.of(context).showPassword == true
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        SizedBox(
                          height: 40.h,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return state is LoginLoading
                                ? Center(
                                    child: ProgressDialog(
                                        status: LocaleKeys.loggingYouIn.tr()),
                                  )
                                : Center(
                                    child: customAuthButton(
                                        text: LocaleKeys.signIn.tr(),
                                        onTap: () {
                                          LoginCubit.of(context).login();
                                       
                                        }),
                                  );
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        InkWell(
                          onTap: () {
                            MagicRouter.navigateTo(const ForgetPassView());
                          },
                          child: Text(LocaleKeys.forgePassword.tr(),
                              style: FontStyles.textStyle15
                                  .copyWith(color: const Color(0xff636363))),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        const OrDivider(),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialButton(
                              img: AssetsData.facebookIcon,
                              imgColor: Colors.white,
                              buttonColor: Colors.blueAccent,
                              onPress: () {},
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SocialButton(
                              img: AssetsData.googleIcon,
                              imgColor: Colors.white,
                              buttonColor: Colors.redAccent.withOpacity(0.9),
                              onPress: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.dontHaveAnAccount.tr(),
                              style: FontStyles.textStyle13
                                  .copyWith(color: const Color(0xff9098B1)),
                            ),
                            InkWell(
                                onTap: () {
                                  MagicRouter.navigateTo(const RegisterView());
                                },
                                child: Text(
                                  LocaleKeys.signUp.tr(),
                                  style: FontStyles.textStyle15.copyWith(
                                      color: kDeepBlue,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShowSnackBar extends StatelessWidget {
  const ShowSnackBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: kDeepBlue,
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
