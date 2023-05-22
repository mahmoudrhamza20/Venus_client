
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class RecentListTile extends StatelessWidget {
  const RecentListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      leading:  Container(
          width: 30.w,
          height: 30.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffD5DDE0),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: kWhite,
          )),
      trailing: const Icon(Icons.delete_outlined,color: kGrey2,),
      title: Text('Kings Cross Underground Statio...',maxLines:1,style: FontStyles.textStyle15.copyWith(overflow: TextOverflow.ellipsis,color: kBlack),),
      subtitle: Text('New York',maxLines:1,style: FontStyles.textStyle13.copyWith(overflow: TextOverflow.ellipsis),),
    );
  }
}