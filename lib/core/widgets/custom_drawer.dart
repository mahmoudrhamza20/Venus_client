import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/app_storage.dart';
import 'package:taxi/core/utils/cache_helper.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/core/widgets/text_button.dart';
import 'package:taxi/features/home/presentations/views_models/delete_account_cubit/delete_account_cubit.dart';
import '../../features/home/presentations/views/contact_us_view.dart';
import '../../features/home/presentations/views/edit_profile_view.dart';
import '../../features/home/presentations/views/faq_view.dart';
import '../../features/home/presentations/views/privacy_policy_view.dart';
import '../../features/home/presentations/views/support_view.dart';
import '../../features/home/presentations/views/ride_history_view.dart';
import '../../features/home/presentations/views/widgets/bottom_sheets.dart';
import '../../features/home/presentations/views_models/profile_cubit/profile_cubit.dart';
import '../../translations/locale_keys.g.dart';
import '../utils/assets.dart';
import '../utils/constants.dart';
import '../utils/styles.dart';
import 'list_tile_of_drawer.dart';

Drawer customDrawer(BuildContext context) {
  const menuItems = <String>[
    '🇸🇦  عربي',
    '🇺🇸  English',
  ];
  const menuItems2 = <String>[
    'عربي  🇸🇦',
    '🇺🇸  English',
  ];
   final cubit = ProfileCubit.of(context);
  return Drawer( 
      child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 260.h,
              color: kDeepBlue,
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () =>
                        MagicRouter.navigateTo(const EditProfileView()),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topRight,
                      children: [
                        CacheHelper.getData(key: 'login')
                            ? Container(
                                width: 90.w,
                                height: 90.w,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        CacheHelper.getData(key: 'photo').toString()
                                        ),
                                    // image: NetworkImage(
                                    //     cubit.userData!.photo
                                    //     ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  
                                ),
                                child: Image.asset(AssetsData.user)),
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
                                  color: kDeepBlue,
                                ),
                                // child: Icon(Icons.edit_outlined),
                              ),
                              Positioned(
                                  bottom: 5.h,
                                  left: 5.w,
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 20.r,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    CacheHelper.getData(key: 'userName')
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Colors.white),
                  ),
                  Text(
                    CacheHelper.getData(key:'phone'),
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ],
              ),
            )
          ],
        ),
        ListTileOfDrawer(
          title: LocaleKeys.rideHistory.tr(),
          onTap: () => MagicRouter.navigateTo(const RideStoryView()),
        ),
          Padding(
          padding: EdgeInsets.only(left: 0.w),
          child: ListTile(
            iconColor: const Color(0xff97ADB6),
            // contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(LocaleKeys.changeLanguage.tr(),
                style: FontStyles.textStyle15.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff4B545A))),
            trailing: PopupMenuButton(
              onSelected: (String newValue) {
                // _SelectedVal = newValue;
                if (newValue == '🇸🇦  عربي') {
                  context.setLocale(const Locale('ar'));
                  CacheHelper.saveData(key: 'lang', value: 'ar');
                } else {
                  context.setLocale(const Locale('en'));
                  CacheHelper.saveData(key: 'lang', value: 'en');
                }
              },
              itemBuilder: (context) {
                return Localizations.localeOf(context).languageCode == 'ar'
                    ? menuItems2
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                        .toList()
                    : menuItems
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                        .toList();
              },
            ),
          ),
        ),
        ListTileOfDrawer(
          title: LocaleKeys.support.tr(),
          onTap: () => MagicRouter.navigateTo(const RaiseIssueView()),
        ),
        ListTileOfDrawer(
          title: LocaleKeys.privacyPolicy.tr(),
          onTap: () => MagicRouter.navigateTo(const PrivacyPolicyView()),
        ),
        ListTileOfDrawer(
          title: LocaleKeys.contactUsBeACaptin.tr(),
          onTap: () => MagicRouter.navigateTo(const ContactUsView()),
        ),
        ListTileOfDrawer(
          title: LocaleKeys.fAQ.tr(),
          onTap: () => MagicRouter.navigateTo(const FAQsView()),
        ),
        ListTileOfDrawer(
          title: LocaleKeys.logOut.tr(),
          onTap: () => buildShowModalBottomSheet(
            context,
            title: LocaleKeys.areYouSureYouWantToLogOut.tr(),
            leftBtnText: LocaleKeys.stay.tr(),
            rightBtnText: LocaleKeys.logOut.tr(),
            rightBtnFunc: () => AppStorage.signOut(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(),
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
              builder: (context, state) {
                return CustomTextButton(
                  title: LocaleKeys.deleteAccount.tr(),
                  textStyle: FontStyles.textStyle15.copyWith(
                      color: const Color(0xff991200),
                      fontWeight: FontWeight.w700),
                  onPressed: () => buildShowModalBottomSheet(
                    context,
                    title: LocaleKeys.areYouSureYouWantToDeletehisAccount.tr(),
                    leftBtnText: LocaleKeys.no.tr(),
                    rightBtnText: LocaleKeys.yes.tr(),
                    rightBtnFunc: () {
                      DeleteAccountCubit.of(context).delete();
                   // MagicRouter.navigateAndPopAll(const LoginView());
                    }
                       // MagicRouter.navigateAndPopAll(const RegisterView()),
                  ),
                );
              },
            ),
          ),
        )
      ],
    ),
  ));
}
