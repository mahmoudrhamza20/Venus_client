import 'package:flutter/material.dart';
import 'package:taxi/features/home/presentations/views/widgets/home_view_body.dart';
import '../../../../core/widgets/custom_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: customDrawer(context),
        body:const HomeViewBody()
    );
  }
}


