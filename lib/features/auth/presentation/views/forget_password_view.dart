// ignore_for_file: missing_required_param, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/auth/presentation/views/widgets/forget_password_view_body.dart';
import 'package:taxi/features/auth/presentation/views_models/phone_auth/phone_auth_cubit.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child:
          const Scaffold(backgroundColor: Colors.white, body: ForgetPassViewBody()),
    );
  }
}
