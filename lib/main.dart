import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi/features/home/presentations/views_models/get_driver_cubit/get_driver_cubit.dart';
import 'package:taxi/features/home/presentations/views_models/post_details_cubit/post_details_cubit.dart';
import 'package:taxi/features/splash/presentation/views/splash_view.dart';
import 'package:taxi/firebase_options.dart';
import 'package:taxi/translations/codegen_loader.g.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/utils/internet_connection_error.dart';
import 'core/utils/magic_router.dart';
import 'core/utils/network_info.dart';
import 'features/auth/presentation/views_models/login_cubit/login_cubit.dart';
import 'features/home/presentations/views_models/cancel_search_cubit/cancelled_search_cubit.dart';
import 'features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';
import 'features/home/presentations/views_models/promo_code_cubit/promo_code_cubit.dart';
import 'features/home/presentations/views_models/rate_model/rate_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(
      name: 'VenusDriver',
      options: Platform.isAndroid
          ? const FirebaseOptions(
              apiKey: 'AIzaSyBBrwYkFi0uyjLdSl5whTcbWjXQO9c_8kw',
              appId: '1:1086435084834:android:6125bc96e71c34e4cdd87b',
              messagingSenderId: '1086435084834',
              projectId: 'venus-captin',
              databaseURL: 'https://venus-captin-default-rtdb.firebaseio.com',
              storageBucket: 'venus-captin.appspot.com',
            )
          : const FirebaseOptions(
              apiKey: 'AIzaSyA1aFIUh4b-UfKrlbm3_NReQ1QlTrMVz4c',
              appId: '1:1086435084834:ios:b622bb3fa7c032c4cdd87b',
              messagingSenderId: '1086435084834',
              projectId: 'venus-captin',
              databaseURL: 'https://venus-captin-default-rtdb.firebaseio.com',
              storageBucket: 'venus-captin.appspot.com',
              iosClientId:
                  '1086435084834-7kmkh3jlipj838buj2qkkc49bfhbbl43.apps.googleusercontent.com',
              iosBundleId: 'com.technomasr.venusridecaptin',
            ));
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      assetLoader: const CodegenLoader(),
      path:
      'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: const Taxi()));
  Bloc.observer = AppBlocObserver();
  await CacheHelper.init();
 
}

class Taxi extends StatefulWidget {
  const Taxi({Key? key}) : super(key: key);

  @override
  State<Taxi> createState() => _TaxiState();
}

class _TaxiState extends State<Taxi> {
   Map _source = {ConnectivityResult.none: false};
  @override
  void initState() {
    
  NetworkConnectivity.instance.initialise();
    NetworkConnectivity.instance.myStream.listen((source) {
      _source = source;
      print('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _source.values.toList()[0]
              ? log('Network Connection')
              : MagicRouter.navigateTo(const InternetConnectionError());
          break;
        case ConnectivityResult.wifi:
          _source.values.toList()[0]
              ? log('Network Connection')
              : MagicRouter.navigateTo(const InternetConnectionError());
          break;
        case ConnectivityResult.none:
        default:
          MagicRouter.navigateTo(const InternetConnectionError());
      }
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => GetDirectionCubit(),
            ),
            BlocProvider(
              create: (context) => PostDetailsCubit(),
            ),
            BlocProvider(
              create: (context) => CancelledSearchCubit(),
            ),
             BlocProvider(
              create: (context) => GetDriverCubit(),
            ),
             BlocProvider(
              create: (context) => RateCubit(),
            ),
             BlocProvider(
              create: (context) => PromoCodeCubit(),
            ),
          ],
          child: MaterialApp(
            home: const SplashView(),
            navigatorKey: navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: kCairo,
              scaffoldBackgroundColor: kWhite,
            ),
          ),
        );
      },
    );
  }
}