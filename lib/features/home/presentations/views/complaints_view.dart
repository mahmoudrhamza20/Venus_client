import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/complaints_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/complaints_cubit/complaints_cubit.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ComplaintsCubit(),
        child: const ComplaintsViewBody(),
      ),
    );
  }
}
