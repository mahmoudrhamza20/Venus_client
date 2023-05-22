import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/features/home/presentations/views_models/faqs_cubit/faqs_cubit.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_icon_back.dart';
import '../../../../../core/widgets/custom_loading_idicator.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../../core/utils/parse_html.dart';

class FAQsViewBody extends StatelessWidget {
  const FAQsViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqsCubit, FaqsState>(
      builder: (context, state) {
        final cubit = FaqsCubit.of(context);
        return state is FaqsLoading
            ? const LoadingIndicator()
            : SafeArea(
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
                      customIconBack(icon: Localizations
                          .localeOf(context)
                          .languageCode == 'en'
                          ? Icons.keyboard_arrow_right
                          : Icons.keyboard_arrow_left,
                          onTap: () => MagicRouter.pop()),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(LocaleKeys.fAQ.tr(), style: FontStyles.textStyle25,),
                  SizedBox(
                    height: 11.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.listOfFAQsData.length,
                      itemBuilder: (context, index) =>  FAQsItem(
                        title: cubit.listOfFAQsData[index].question,
                        desc: parseHtmlString(cubit.listOfFAQsData[index].answer) ,),
                    ),
                  )
                ],
              ),


            ),
          ),
        );
      },
    );
  }
}

class FAQsItem extends StatelessWidget {
  const FAQsItem({
    super.key, required this.title, required this.desc,
  });
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
       title,
        style: FontStyles.textStyle15.copyWith(color: const Color(0xff4B545A)),
      ),
      children: <Widget>[
        ListTile(
          title: Text(
              desc,
            style: FontStyles.textStyle15.copyWith(
                color: const Color(0xff4B545A)),
          ),
        )
      ],
    );
  }
}