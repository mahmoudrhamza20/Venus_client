import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/faqs_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/faqs_cubit/faqs_cubit.dart';

class FAQsView extends StatelessWidget {
  const FAQsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => FaqsCubit()..getFAQs(),
        child: const FAQsViewBody(),
      ),
    );
  }
}

