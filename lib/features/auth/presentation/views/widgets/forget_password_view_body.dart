import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/core/widgets/custom_text_form.dart';
import 'package:taxi/core/widgets/progress_dialog.dart';
import 'package:taxi/features/auth/presentation/views_models/phone_auth/phone_auth_cubit.dart';
import 'package:taxi/global_variables.dart';
import 'package:taxi/translations/locale_keys.g.dart';


class ForgetPassViewBody extends StatefulWidget {
  const ForgetPassViewBody({super.key});

  @override
  State<ForgetPassViewBody> createState() => _ForgetPassViewBodyState();
}

class _ForgetPassViewBodyState extends State<ForgetPassViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = PhoneAuthCubit.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Image(
                image: const AssetImage('assets/images/logo.png'),
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
                        SizedBox(
                          height: 40.h,
                        ),
                        BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
                          builder: (context, state) {
                            return state is Loading
                                ? Center(
                                    child: ProgressDialog(
                                        status: 'Logging you in...'))
                                : Center(
                                    child: customAuthButton(
                                        text: LocaleKeys.confirm.tr(),
                                        onTap: cubit.phoneAuth,
                                        ),
                                  );
                          },
                        )
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
