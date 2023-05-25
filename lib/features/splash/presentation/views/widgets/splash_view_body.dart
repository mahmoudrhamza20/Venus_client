import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taxi/core/utils/assets.dart';
import 'package:taxi/features/onBoarding/data/presentation/view/on_boarding_view.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../after_splash/presentations/views/after_splash_view.dart';

class SplashViewBody extends StatefulWidget {
  static const String id = 'splash';
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 5), _goNext);
  }

  // bool? onBoarding = CacheHelper.getBoolean(key: 'onBoarding') ;
  _goNext() {
    if (CacheHelper.getData(key: 'login') == true) {
     // MagicRouter.navigateAndPopAll(const HomeView());
      MagicRouter.navigateAndPopAll(const AfterSplashView());
    } else {
      MagicRouter.navigateAndPopAll(const OnBoardingView());
    }
  }
  //   if(onBoarding != null){
  //     navigateAndFinish(context, AppRouter.kHomeView);
  //   }
  //   else{ navigateAndFinish(context, AppRouter.kOnBoarding);}
  //
  // }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AssetsData.splash,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          child: Image.asset(AssetsData.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
