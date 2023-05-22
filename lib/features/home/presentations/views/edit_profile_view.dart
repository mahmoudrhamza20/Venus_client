import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/home/presentations/views/widgets/edit_profile_view_body.dart';
import 'package:taxi/features/home/presentations/views_models/profile_cubit/profile_cubit.dart';

import '../../../../core/widgets/custom_loading_idicator.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>   ProfileCubit()
        ..getProfileDetails(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state is GetProfileDetailsLoading
                ? const LoadingIndicator()
                : const EditProfileViewBody();
          },
        ),
      ),
    );
  }
}
