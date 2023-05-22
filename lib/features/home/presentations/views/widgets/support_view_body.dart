import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/constants.dart';
import 'package:taxi/core/utils/styles.dart';
import 'package:taxi/core/widgets/custom_button.dart';
import 'package:taxi/features/home/presentations/views_models/support_cubit/support_cubit.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_loading_idicator.dart';
import '../../../../../translations/locale_keys.g.dart';
import 'contact_us_view_body.dart';

class RaiseIssueViewBody extends StatelessWidget {
   const RaiseIssueViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = SupportCubit.of(context);
    return SafeArea(
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
            height: 20.h,),
              Text(LocaleKeys.tellUs.tr(),style: FontStyles.textStyle15.copyWith(fontWeight: FontWeight.w700,color: kBlack),),
              SizedBox(height: 15.h,),
              CustomMessageTextField(
                hint: LocaleKeys.yourMessageHere.tr(),
                maxLines: 5,
                controller: cubit.msgController,
              ),
              SizedBox(height: 50.h,),
              BlocBuilder<SupportCubit, SupportState>(
                builder: (context, state) {
                  return state is SendMsgLoading
                      ? const Center(child: LoadingIndicator())
                      : Center(
                    child: CustomButton(
                      text: LocaleKeys.submit.tr(),
                      textColor: kWhite,
                      backgroundColor: kDeepBlue,
                      onPressed: ()=>cubit.sendMsgSupport(),
                    ),
                  );
                },
              ),
            ],
          ),

        ),
      ),
    );
  }
}
