
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField(
//       {Key? key,
//       this.isClickable = true,
//       required this.controller,
//       required this.hintText,
//       required this.prefix,
//       this.validator,
//       required this.inputType,
//       this.suffix,
//       this.suffixPressed,
//       this.onTap,
//       this.onChange,
//       this.isPassword = false,
//       this.onSubmitted,  this.isBorder= true,  this.isPrefix = true})
//       : super(key: key);
//
//   final TextEditingController controller;
//   final String hintText;
//   final IconData prefix;
//   final String? Function(String?)? validator;
//   final TextInputType inputType;
//   final bool isPassword;
//   final bool isBorder;
//   final bool isPrefix;
//
//   final IconData? suffix;
//   final void Function()? suffixPressed;
//   final void Function()? onTap;
//   final void Function(String)? onChange;
//   final void Function(String)? onSubmitted;
//   final bool isClickable;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//
//       onFieldSubmitted: onSubmitted,
//       controller: controller,
//       keyboardType: inputType,
//       obscureText: isPassword,
//      // cursorColor: kPrimaryColor,
//       decoration: InputDecoration(
//         fillColor: Colors.white,
//         filled: true,
//         errorBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.grey.shade300)) ,
//         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6),borderSide: BorderSide(color: Colors.grey.shade300)),
//         border: isBorder?   OutlineInputBorder(borderRadius:BorderRadius.circular(6),borderSide: BorderSide(color: Colors.grey.shade300) ) :InputBorder.none,
//         hintText: hintText,
//         prefixIcon: isPrefix? Icon(prefix):null,
//        // prefixIconColor: kPrimaryColor,
//         suffixIcon: suffix != null
//             ? IconButton(
//                 onPressed: suffixPressed,
//                 icon: Icon(
//                   suffix,
//                 ))
//             : null,
//       ),
//       validator: validator,
//       onTap: onTap,
//       onChanged: onChange,
//       enabled: isClickable,
//     );
//   }
// }




Widget customTextField(
    {
      @required Icon? endIcon,
      @required Widget? prefix,
      @required String? hintText,
      @required Color? color,
      required bool isPassword,
      required TextInputType type,
      required TextEditingController controller,
      VoidCallback? onPressed}) {
  return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black.withOpacity(.8)),
      obscureText: isPassword,
      keyboardType: type,
      
      cursorColor: kDeepBlue,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        filled: true,
        fillColor:  color??const Color(0xfff5f5f5),
        prefixIconColor: kDeepBlue,
        prefixIcon: prefix,
        suffixIcon: endIcon != null
            ? IconButton(
          color: const Color(0xff97ADB6),
          splashRadius: 1,
          onPressed: onPressed,
          icon: endIcon,
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0xffB5B5B5)),
      ));
}
