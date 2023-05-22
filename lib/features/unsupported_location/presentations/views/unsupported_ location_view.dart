import 'package:flutter/material.dart';
import 'package:taxi/features/unsupported_location/presentations/views/widgets/unsupported_%20location_view_body.dart';
import '../../../../core/widgets/custom_drawer.dart';

class UnsupportedLocationView extends StatelessWidget {
  const UnsupportedLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          drawer: customDrawer(context),
          body: const UnsupportedLocationViewBody(),

      ),
    );

  }
}
