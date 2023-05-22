import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/after_splash/presentations/views/after_splash_view.dart';
import '../../../../../core/utils/app_storage.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../data/repos/login_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final loginRepo = LoginRepo();
  static LoginCubit of(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey =GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;
  bool localeIsEn = true;

  Future login() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(
        LocaleKeys.noInternetConnectivity.tr(),
      );
    }

    if ( emailController.text.length < 10) {
      showSnackBar(
        LocaleKeys.pleaseProvideAValidEmailAddress.tr(),
      );
      return;
    }

    if (passwordController.text.length < 8) {
      showSnackBar(
        LocaleKeys.pleaseProvideAValidPasswordShouldGreaterThan8Character.tr(),
      );
      return;
    }
    emit(LoginLoading());
    final res =
    await loginRepo.login(emailController.text, passwordController.text);
    res.fold(
          (err) {
        showSnackBar(AppStorage.getLang == 'en'
            ? err
            : 'Please check your data again, you have an error in the data');
        emit(LoginInitial());
      },
          (res) async {
        emit(LoginInitial());
        await CacheHelper.saveData(key: 'userId', value: res.data.id);
        await CacheHelper.saveData(key: 'userName', value: res.data.name);
      //  await CacheHelper.saveData(key: 'email', value: res.data.email);
        await CacheHelper.saveData(key: 'photo', value: res.data.photo);
        await CacheHelper.saveData(key: 'phone', value: res.data.phone);
        await CacheHelper.saveData(key: 'login', value: true);
        print('-----------------');
       // print(CacheHelper.getData(key: 'email'));
        print(CacheHelper.getData(key: 'userId'));
        print(CacheHelper.getData(key: 'userName'));
        print('-----------------');
        MagicRouter.navigateAndPopAll(const AfterSplashView());
      },
    );
  }
}
