import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/features/after_splash/presentations/views/after_splash_view.dart';
import 'package:taxi/features/auth/data/repos/register_repo.dart';
import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../global_variables.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../views/verify_code_register_view.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool showPassword = true;
  bool showConPassword = true;
  final TextEditingController nameController = TextEditingController();
 // final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  var receivedID = '';
  final registerRepo = RegisterRepo();


Future<void> submitPhoneNumber() async {
    emit(Loading());
    log('+${selectedCountry.phoneCode}${phoneNumberController.text}');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${selectedCountry.phoneCode}${phoneNumberController.text}',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    log('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    log('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    log('codeSent');
    log(verificationId);
    
  
   CacheHelper.saveData(key: 'receivedID', value: verificationId);
    MagicRouter.navigateTo(const VerifyCodeRegisterView());
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    log('codeAutoRetrievalTimeout');
  }

 Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      register();
      emit(PhoneOTPVerified());
    } catch (error) {
      log("$error");
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }
  // Future<void> submitOTP(String otpCode) async {
  //   print(otpCode);
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: CacheHelper.getData(key: 'receivedID'), smsCode: otpCode);
  //     await signIn(credential);
  //     await  MagicRouter.navigateAndPopAll(const HomeView());
  // }

 Future<void> verifyOTPCode(otpCode) async {
    emit(PhoneNumberSubmited());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: CacheHelper.getData(key: 'receivedID'),
      smsCode: otpCode,
    );
    try {
      await auth.signInWithCredential(credential).then((value) {
       log('User Login In Successful');
        MagicRouter.navigateTo(const AfterSplashView());
        emit(PhoneOTPVerified());
      });
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }


  Future register() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(
        LocaleKeys.noInternetConnectivity.tr(),
      );
    }
    if (passwordController.text.length < 8) {
      showSnackBar(
        LocaleKeys.pleaseProvideAValidPasswordShouldGreaterThan8Character.tr(),
      );
      return;
    }
    if (phoneNumberController.text.length < 10) {
      showSnackBar(
        LocaleKeys.pleaseProvideAValidPhoneNumber.tr(),
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(
        LocaleKeys.PleaseEnterASimilarPassword.tr(),
      );
      return;
    }
    emit(RegisterLoading());
    final res = await registerRepo.register(
        nameController.text,
       // emailController.text,
        phoneNumberController.text,
        passwordController.text,
        confirmPasswordController.text
    );
    res.fold(
          (err) {
       showSnackBar(err);
       log(err.toString());
        emit(RegisterInitial());
      },
          (res) async {
            showSnackBar( CacheHelper.getData(key: 'lang') !='en'
                  ? res.message:'Logged in successfully');
        emit(RegisterInitial());
        await CacheHelper.saveData(key: 'userId', value: res.data.id);
        await CacheHelper.saveData(key: 'userName', value: res.data.name);
       // await CacheHelper.saveData(key: 'email', value: res.data.email);
        await CacheHelper.saveData(key: 'photo', value: res.data.photo);
        await CacheHelper.saveData(key: 'phone', value: res.data.phone);
        await CacheHelper.saveData(key: 'login', value: true);
       submitPhoneNumber();
      },
    );
  }}


  // IconData suffix = Icons.visibility_off;
  // bool isPasswordShown= true;
  // void changePasswordVisibility (){
  //   isPasswordShown = !isPasswordShown ;
  //   suffix = isPasswordShown ? Icons.visibility_off : Icons.visibility;
  //   emit(ChangeRegisterPasswordVisibility());
  // }

