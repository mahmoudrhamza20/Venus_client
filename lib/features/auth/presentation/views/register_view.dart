import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/auth/presentation/views/widgets/register_view_body.dart';
import 'package:taxi/features/auth/presentation/views_models/register_cubit/register_cubit.dart';


class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SafeArea(child: BlocProvider(
      create: (context) => RegisterCubit(),
      child: const RegisterViewBody(),
    )));
  }
}
