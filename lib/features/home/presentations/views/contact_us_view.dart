import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/contact_us_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/contact_us_cubit/contact_us_cubit.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: BlocProvider(
        create: (context) => ContactUsCubit()..getContactUs(),
        child: const ContactUsViewBody(),
      ),
    );
  }
}
