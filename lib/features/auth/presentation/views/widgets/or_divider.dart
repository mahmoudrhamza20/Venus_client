
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/constants.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../translations/locale_keys.g.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Container(
        height: 1.h,
        width: 40.w,
        color: Colors.grey[300],),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(LocaleKeys.orSignINWIth.tr(), style: FontStyles.textStyle13.copyWith(
          color:kBlack,fontWeight: FontWeight.w700
        ),),
      ),
      Container(
        height: 1.h,
        width: 40.w,
        color: Colors.grey[300],),
    ],);
  }
}