import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/support_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/support_cubit/support_cubit.dart';

class RaiseIssueView extends StatelessWidget {
  const RaiseIssueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SupportCubit(),
        child: const RaiseIssueViewBody(),
      ),
    );
  }
}
