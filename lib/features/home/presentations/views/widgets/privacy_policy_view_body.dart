
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/core/widgets/custom_loading_idicator.dart';
import 'package:taxi/features/home/presentations/views_models/privacy_cubit/privacy_cubit.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/utils/parse_html.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../translations/locale_keys.g.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({Key? key}) : super(key: key);
final String privacyPolicy = 'THESE TERMS AND CONDITIONS (“Conditions”) DEFINE THE BASIS UPON WHICH GETT WILL PROVIDE YOU WITH ACCESS TO THE GETT MOBILE APPLICATION PLATFORM, PURSUANT TO WHICH YOU WILL BE ABLE TO REQUEST CERTAIN TRANSPORTATION SERVICES FROM THIRD PARTY DRIVERS BY PLACING ORDERS THROUGH GETT’S MOBILE APPLICATION PLATFORM. THESE CONDITIONS (TOGETHER WITH THE DOCUMENTS REFERRED TO HEREIN) SET OUT THE TERMS OF USE ON WHICH YOU MAY, AS A CUSTOMER, USE THE APP AND REQUEST TRANSPORTATION SERVICES. BY USING THE APP AND TICKING THE ACCEPTANCE BOX, YOU INDICATE THAT YOU ACCEPT THESE TERMS OF USE WHICH APPLY, AMONG OTHER THINGS, TO ALL SERVICES HEREINUNDER TO BE RENDERED TO OR BY YOU VIA THE APP WITHIN THE UK AND THAT YOU AGREE TO ABIDE BY THEM. USE THE APP AND REQUEST TRANSPORTATION SERVICES.';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyCubit, PrivacyState>(
  builder: (context, state) {
    final cubit = PrivacyCubit.of(context);
    return state is PrivacyLoading
        ? const LoadingIndicator()
        : SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(
                  height: 40.h,
                ),
                Text(LocaleKeys.privacyPolicy.tr(),style: FontStyles.textStyle25,),
                SizedBox(
                  height: 11.h,
                ),
                Text(parseHtmlString(cubit.privacyData!.content),style: FontStyles.textStyle15.copyWith(color: kBlack),),
              ],
            ),


          ),
        ),
      ),
    );
  },
);
  }
}