import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/features/auth/presentation/views_models/register_cubit/register_cubit.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading_idicator.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../core/widgets/progress_dialog.dart';
import '../../../../../global_variables.dart';
import '../../../../../translations/locale_keys.g.dart';



class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.get(context);
    // final phineAuthcubit = PhoneAuthCubit.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Image(
                  image: const AssetImage(AssetsData.logo),
                  alignment: Alignment.center,
                  height: 105.h,
                  width: 267.w,
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
                        LocaleKeys.name.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                      customTextField(
                          prefix: const Icon(Icons.person),
                          controller: cubit.nameController,
                          isPassword: false,
                          type: TextInputType.name),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   LocaleKeys.email.tr(),
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 13.sp),
                      // ),
                      // customTextField(
                      //     prefix: const Icon(Icons.mail),
                      //     controller: cubit.emailController,
                      //     isPassword: false,
                      //     type: TextInputType.emailAddress),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        LocaleKeys.phoneNumber.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),

                      customTextField(
                            type: TextInputType.phone,
                            onPressed: () {},
                            endIcon: const Icon(Icons.phone),
                            controller: cubit.phoneNumberController,
                            isPassword: false,
                            prefix: InkWell(
                              onTap: () {
                                showCountryPicker(
                                    countryListTheme: CountryListThemeData(
                                        bottomSheetHeight: 500.h),
                                    context: context,
                                    onSelect: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                      });
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(6.0.w),
                                child: Text(
                                  '${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}',
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                            ),
                            hintText: ''),
                      // customTextField(
                      //     prefix: const Icon(Icons.phone),
                      //     controller: cubit.phoneController,
                      //     isPassword: false,
                      //     type: TextInputType.phone
                      //     ),
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
                          controller: cubit.passwordController,
                          isPassword: cubit.showPassword == true ? true : false,
                          type: TextInputType.visiblePassword,
                          onPressed: () {
                            setState(() {
                              cubit.showPassword = !cubit.showPassword;
                            });
                          },
                          endIcon: cubit.showPassword == true
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        LocaleKeys.confirmPassword.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                      customTextField(
                          prefix: const Icon(Icons.lock),
                          controller: cubit.confirmPasswordController,
                          isPassword:
                              cubit.showConPassword == true ? true : false,
                          type: TextInputType.visiblePassword,
                          onPressed: () {
                            setState(() {
                              cubit.showConPassword = !cubit.showConPassword;
                            });
                          },
                          endIcon: cubit.showConPassword == true
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                      SizedBox(
                        height: 40.h,
                      ),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          return state is Loading
                              ? Center(
                                    child: ProgressDialog(
                                        status: 'Registar you in...'))
                              : Center(
                                child: customAuthButton(
                                text: LocaleKeys.signUp.tr(),
                                onTap: () => cubit.register()
                                ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.alreadyHaveAnAccount.tr(),
                            style: FontStyles.textStyle13
                                .copyWith(color: const Color(0xff9098B1)),
                          ),
                          InkWell(
                              onTap: () {
                                MagicRouter.pop();
                              },
                              child: Text(
                                LocaleKeys.signIn.tr(),
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
    );
  }
}
