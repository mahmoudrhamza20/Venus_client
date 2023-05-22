import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
        child:SizedBox(
          height: 250.h,
          width: 250.w,
          child: Lottie.asset('assets/json/carloading.json'))
        );
    // Center(
    //     child: SpinKitSquareCircle(
    //       color: kDeepBlue,
    //       size: 50.0,
    //     )
    //     );
  }
}
