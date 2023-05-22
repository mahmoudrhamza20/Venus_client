import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_drawer.dart';
import 'widgets/after_splash_view_body.dart';

class AfterSplashView extends StatelessWidget {
  const AfterSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer:  customDrawer(context),
      body: const SafeArea(child: AfterSplashViewBody()),
    );
  }
}