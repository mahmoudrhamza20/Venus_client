
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key, required this.title,required this.onPressed, required this.textStyle,
  }) : super(key: key);
  final void Function()? onPressed ;
  final String title ;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title.toUpperCase(),style:textStyle ,),
    );
  }
}