import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles.dart';

class ListTileOfDrawer extends StatelessWidget {
  const ListTileOfDrawer({
    super.key, this.onTap,
    required this.title,
    this.icon =Icons.arrow_forward_ios_outlined
  });
  final void Function()? onTap ;
  final String title ;
  final IconData icon ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: Icon(icon,color:const Color(0xff97ADB6) ,size: 23.w,),
      title: Text(title,style: FontStyles.textStyle15.copyWith(fontWeight: FontWeight.w700,color: const Color(0xff4B545A)),),
      dense: true,
    );
  }
}