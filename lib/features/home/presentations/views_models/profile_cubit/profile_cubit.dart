import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi/features/home/presentations/views/home_view.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../data/repos/profile_repo.dart';


part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit of(context) => BlocProvider.of(context);
  final profileRepo = ProfileRepo();
  UserDta? userData;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // final passwordController = TextEditingController();
  // final passwordConfirmationController = TextEditingController();
  XFile? photo;

  Future getProfileDetails() async {
    emit(GetProfileDetailsLoading());
    final res = await profileRepo.getProfileDetails();

    res.fold(
      (err) {
        showSnackBar(err);
        emit(ProfileInitial());
      },
      (res) async {
        userData = res.data;
        nameController.text = res.data.name;
       // emailController.text = res.data.email;
        phoneController.text = res.data.phone;
        // passwordController.text = AppStorage.getPassword!;
        // passwordConfirmationController.text = AppStorage.getPassword!;
        emit(GetProfileDetailsLoaded());
      },
    );
  }

  Future editProfileDetails() async {
    emit(EditProfileDetailsLoading());
    final res = await profileRepo.editProfileDetails(
      nameController.text,
      phoneController.text,
      
    );

    res.fold(
      (err) {
        showSnackBar(err);
        emit(ProfileInitial());
      },
      (res) async {
        await CacheHelper.saveData(key: 'userName', value: res.data.name);
        // await CacheHelper.saveData(key: 'email', value: res.data.email);
        // await CacheHelper.saveData(key: 'phone', value: res.data.email);
        await CacheHelper.saveData(key: 'photo', value: res.data.photo);
        MagicRouter.navigateAndPopAll(const HomeView());
        emit(ProfileInitial());
      },
    );
  }

  Future editImageProfile() async {
    emit(EditProfileDetailsLoading());
    final res = await profileRepo.editImageProfile(photo!);

    res.fold(
      (err) {
        showSnackBar(err);
        emit(ProfileInitial());
      },
      (res) async {
        showSnackBar('تم تحديث الصوره الشخصيه');
        await CacheHelper.saveData(key: 'photo', value: res.data.photo);
        emit(ProfileInitial());
      },
    );
  }
}
