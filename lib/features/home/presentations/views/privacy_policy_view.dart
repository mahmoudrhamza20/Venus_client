import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/privacy_policy_view_body.dart';

import '../views_models/privacy_cubit/privacy_cubit.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => PrivacyCubit()..getPrivacy(),
        child: const PrivacyPolicyViewBody(),
      ),
    );
  }
}

