import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/ride_story_item_details_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/hisroty_ride_details_cubit/histoty_ride_details_cubit.dart';


class RideStoryItemDetailsView extends StatelessWidget {
  const RideStoryItemDetailsView({Key? key, required this.endTime, required this.startTime, required this.startTAdd, required this.endAdd, required this.cost, required this.fee, required this.total, required this.time, required this.dis, required this.photo, required this.name, required this.type, required this.rate,required this.late,}) : super(key: key);
 final String endTime;
 final String startTime;
   final String startTAdd;
   final String endAdd;
   final dynamic cost;
   final dynamic fee;
   final dynamic total;
   final String time;
   final String dis;
   final String photo;
   final String name;
   final String type;
   final dynamic rate;
   final dynamic late;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(create: (BuildContext context) =>HistotyRideDetailsCubit(),
      child: RideStoryItemDetailsViewBody(cost: cost, endTime: endTime, name:name, rate: rate, type: type, dis: dis, endAdd: endAdd, fee: fee, photo: photo, startTAdd: startTAdd, total: total, startTime: startTime, time: time,late :late)),
    );
  }
}
