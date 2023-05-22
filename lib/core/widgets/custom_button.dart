import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.textColor,
      this.borderRadius,
      this.fontSize,
      required this.backgroundColor,
        this.onPressed,
        this.borderColor
      })
      : super(key: key);
  final String text;
  final Color textColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? fontSize;
  final Color backgroundColor;
  final void Function()? onPressed ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width:280.w,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(15.r),
          ),
        ),
        child: Text(
          text,
          style: FontStyles.textStyle18.copyWith(color: textColor)
        ),
      ),
    );
  }
}



Widget customAuthButton({required String text, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50.h,
      width: 280.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          color: kDeepBlue
      ),
      child: Center(
        child: Text(
            text,
            style: FontStyles.textStyle18.copyWith(color: Colors.white)
        ),
      ),
    ),
  );
}