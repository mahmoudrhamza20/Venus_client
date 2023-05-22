import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/ride_story_view_body.dart';

import '../views_models/hisroty_ride_details_cubit/histoty_ride_details_cubit.dart';
import '../views_models/ride_history_cubit/ride_history_cubit.dart';

class RideStoryView extends StatelessWidget {
  const RideStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
         BlocProvider(
              create: (context) => HistotyRideDetailsCubit(),
            ),
            BlocProvider(
              create: (context) => RideHistoryCubit()..getRideHistory(),
            ),
      ],
      child: const Scaffold(
        body: RideStoryViewBody(),
      ),
    );
  }
}
