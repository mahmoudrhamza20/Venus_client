import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/features/auth/presentation/views_models/reset_pass_cubit/reset_pass_cubit.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import '../../../../../core/widgets/progress_dialog.dart';
import '../../../../../translations/locale_keys.g.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({Key? key}) : super(key: key);

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {

  @override
  Widget build(BuildContext context) {
    final cubit = ResetPassCubit.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customIconBack( icon: Localizations.localeOf(context).languageCode == 'en'
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                      onTap: ()=> MagicRouter.pop()),
                ],
              ),
              Image.asset(AssetsData.logo),
              SizedBox(
                height: 27.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.newPassword.tr(),
                    style: FontStyles.textStyle13
                        .copyWith(color: kBlack, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
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
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.confirmPassword.tr(),
                    style: FontStyles.textStyle13
                        .copyWith(color: kBlack, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              customTextField(
                  prefix: const Icon(Icons.lock),
                  controller: cubit.confirmPasswordController,
                  isPassword: cubit.showConPassword == true ? true : false,
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
                height: MediaQuery.of(context).size.height * .2,
              ),
              BlocBuilder<ResetPassCubit, ResetPassState>(
                builder: (context, state) {
                  return state is ResetPassLoading
                      ? Center(child: ProgressDialog(status: LocaleKeys.loggingYouIn.tr()),)
                      : Center(
                           child: customAuthButton(
                        text: LocaleKeys.confirm.tr(),
                        onTap: () async {
                          cubit.resetPass();
                        }),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
