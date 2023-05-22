import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/features/auth/presentation/views/reset_password_view.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_loading_idicator.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../views_models/profile_cubit/profile_cubit.dart';
import 'package:taxi/core/utils/cache_helper.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({Key? key}) : super(key: key);

  // File? image;
  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return state is EditProfileDetailsLoading
                    ? const LoadingIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 32.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customIconBack(
                                icon: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                onTap: () => MagicRouter.pop(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          InkWell(
                            onTap: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              cubit.photo = image!;
                              await cubit.editImageProfile();
                              // buildGetImageBottomSheet(context)
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topRight,
                              children: [
                                cubit.photo == null
                                    ? cubit.userData?.photo == null
                                    ?
                                // image != null
                                //     ?
                                // Container(
                                //         width: 90.w,
                                //         height: 90.w,
                                //         decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           image: DecorationImage(
                                //               fit: BoxFit.cover,
                                //               image: FileImage(
                                //                 image!,
                                //               )),
                                //         ),
                                //       )
                                //     :
                                Container(
                                    width: 90.w,
                                    height: 90.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/user.png'))
                                    : Container(
                                    width: 90.w,
                                    height: 90.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            cubit.userData!.photo),
                                      ),
                                    ))
                                    : Container(
                                  width: 90.w,
                                  height: 90.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(cubit.photo!.path)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -6.h,
                                  right: -1.w,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 25.w,
                                        width: 25.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kWhite,
                                        ),
                                        // child: Icon(Icons.edit_outlined),
                                      ),
                                      Positioned(
                                          bottom: 5.h,
                                          left: 5.w,
                                          child: Icon(Icons.edit_outlined,
                                              size: 20.r, color: kDeepBlue))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            CacheHelper.getData(key: 'userName'),
                            //LocaleKeys.userName.tr(),
                            style: FontStyles.textStyle20,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Card(
                            elevation: 4,
                            shadowColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  buildTextFieldOfEditProfile(
                                    hint: LocaleKeys.userName.tr(),
                                    icon: Icons.person_2_outlined,
                                      controller: cubit.nameController
                                  ),
                                  // buildTextFieldOfEditProfile(
                                  //   hint: 'carson@mobility.com',
                                  //   icon: Icons.mail,
                                  //     controller: cubit.emailController
                                  // ),
                                  buildTextFieldOfEditProfile(
                                    hint: '+1 926 483 32 52',
                                    icon: Icons.phone,
                                    controller: cubit.phoneController
                                  ),
                                  InkWell(
                                    onTap: () => MagicRouter.navigateAndPopAll(
                                        const ResetPasswordView()),
                                    child: buildTextFieldOfEditProfile(
                                        hint: LocaleKeys.changePassword.tr(),
                                        icon: Icons.lock,
                                        enabled: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          CustomButton(
                               onPressed: ()=> cubit.editProfileDetails(),
                              text: LocaleKeys.submit.tr(),
                              textColor: kWhite,
                              backgroundColor: kDeepBlue),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextFieldOfEditProfile({hint, icon, enabled = true,@required TextEditingController? controller,}) {
    return TextField(
      controller: controller,
      cursorColor: kDeepBlue,
      enabled: enabled,
      decoration: InputDecoration(
          icon: Container(
              width: 30.w,
              height: 30.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffD5DDE0),
              ),
              child: Icon(
                icon,
                color: kWhite,
              )),
          hintText: hint,
          hintStyle: FontStyles.textStyle15,
          focusColor: kWhite,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kDeepBlue))),
    );
  }
}
