import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/features/home/presentations/views_models/contact_us_cubit/contact_us_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_loading_idicator.dart';
import '../../../../../translations/locale_keys.g.dart';

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsState>(
      builder: (context, state) {
        final cubit = ContactUsCubit.of(context);
        return state is ContactUsLoading
            ? const LoadingIndicator()
            : SafeArea(
                child: SingleChildScrollView(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.contactUs.tr(),
                                style: FontStyles.textStyle18,
                              ),
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
                            height: 10.h,
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
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mark_email_read_outlined,
                                        color: Colors.blue.shade100,
                                        size: 20.w,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        cubit.contactUsData?.email??'',
                                        style: FontStyles.textStyle15,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    LocaleKeys.followOnSocialMedia.tr(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1D1617)),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ContactUsSocialIcon(
                                        image: AssetsData.face,
                                        link: cubit.contactUsData!.facebook??'',
                                      ),
                                      ContactUsSocialIcon(
                                        image: AssetsData.insta,
                                        link: cubit.contactUsData!.instgram?? '',
                                      ),
                                      ContactUsSocialIcon(
                                        image: AssetsData.twitter,
                                        link: cubit.contactUsData!.twitter??'',
                                      ),
                                      ContactUsSocialIcon(
                                        image: AssetsData.tiktok,
                                        link: cubit.contactUsData!.tiktok?? '',
                                      ),
                                      ContactUsSocialIcon(
                                        image: AssetsData.snap,
                                        link: cubit.contactUsData!.snapchat?? '',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 58.h,
                          ),
                          Text(
                            LocaleKeys.sendAMesssege.tr(),
                            style: FontStyles.textStyle13.copyWith(
                                fontWeight: FontWeight.w700, color: kBlack),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomMessageTextField(
                            hint: LocaleKeys.yourMessageHere.tr(),
                            maxLines: 5,
                            controller: cubit.msgController,
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
                          BlocBuilder<ContactUsCubit, ContactUsState>(
                            builder: (context, state) {
                              return state is SendMsgLoading
                                  ? const Center(child: LoadingIndicator())
                                  : Center(
                                child: CustomButton(
                                  text: LocaleKeys.submit.tr(),
                                  textColor: kWhite,
                                  backgroundColor: kDeepBlue,
                                   onPressed: ()=>cubit.sendMsg(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 28.h,
                          ),
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

class ContactUsSocialIcon extends StatelessWidget {
  const ContactUsSocialIcon({
    super.key,
    required this.image,
    required this.link,
  });

  final String image;

  final String link;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch $link');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(),
      child: Container(
        width: 35.w,
        height: 35.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: .5),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(image),
            )),
      ),
    );
  }
}

class CustomMessageTextField extends StatelessWidget {
  const CustomMessageTextField(
      {Key? key,
      required this.hint,
      this.maxLines = 1,
      this.onSave,
      this.onChanged, required this.controller})
      : super(key: key);

  final String hint;
  final int maxLines;
  final TextEditingController controller;
  final void Function(String?)? onSave;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSave,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '$hint ${LocaleKeys.isRequired.tr()}';
        } else {
          return null;
        }
      },
      cursorColor: kDeepBlue,
      style: const TextStyle(color: kDeepBlue),
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xfff5f5f5),
          hintText: hint,
          hintStyle: FontStyles.textStyle15,
          border: buildOutlineBorder(),
          enabledBorder: buildOutlineBorder(),
          focusedBorder: buildOutlineBorder(Colors.grey.shade400)),
    );
  }

  OutlineInputBorder buildOutlineBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
