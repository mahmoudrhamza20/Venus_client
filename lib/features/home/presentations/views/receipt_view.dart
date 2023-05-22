import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/receipt_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key, required this.startTime, required this.endTime, required this.startTAdd, required this.endAdd, required this.cost, required this.fee, required this.total, required this.time, required this.dis, required this.late,required this.discount}) : super(key: key);
   final String startTime;
   final String endTime;
   final String startTAdd;
   final String endAdd;
   final String cost;
   final String fee;
   final String total;
   final String time;
   final String dis;
   final dynamic late;
   final dynamic discount;
   
     
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => GetDirectionCubit(),
      child:  WillPopScope(
       onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(child: ReceiptViewBody(cost: cost, dis: dis, endAdd: endAdd, fee: fee, startTime: startTime, endTime: endTime, startTAdd: startTAdd, time: time, total: total, late: late, discount: discount,)),
        ),
      ),
    );
  }
}
