import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/core/utils/constants.dart';

import '../../../../../../core/utils/styles.dart';
import '../../../models/on_boarding_model.dart';


class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({Key? key, required this.boarding}) : super(key: key);
  final OnBoardingModel boarding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
                image: AssetImage(
                  boarding.image,
                )),),
         SizedBox(
          height: 30.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                boarding.title,
                style: FontStyles.textStyle18,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
            // Text(
            //   boarding.desc,
            //   style: FontStyles.textStyle15.copyWith(color: kBlack),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,

            // ),
          ],
        )
      ],
    );
  }
}