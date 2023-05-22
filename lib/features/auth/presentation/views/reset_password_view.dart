import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/auth/presentation/views_models/reset_pass_cubit/reset_pass_cubit.dart';
import 'widgets/reset_password_view_body.dart';


class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: kBackground,
      //  appBar: AppBar(
      //    automaticallyImplyLeading: true,
      //    backgroundColor: Colors.white,
      //    iconTheme:const IconThemeData(color: Colors.black, ) ,
      //
      //    centerTitle: true,
      //    elevation: 0,
      //  ),
        body: SafeArea(child: BlocProvider(
          create: (context) => ResetPassCubit(),
          child: const ResetPasswordViewBody(),
        ))
    );
  }
}
