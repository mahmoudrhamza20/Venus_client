import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/utils/cache_helper.dart';
import 'package:taxi/core/utils/magic_router.dart';
import 'package:taxi/core/widgets/custom_snackbar.dart';
import 'package:taxi/features/auth/presentation/views/verify_code_view.dart';
import 'package:taxi/features/auth/data/repos/phone_auth_repo.dart';
import 'package:taxi/global_variables.dart';
import 'package:taxi/translations/locale_keys.g.dart';

import '../../views/reset_password_view.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());
  static PhoneAuthCubit of(context) => BlocProvider.of(context);
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  var receivedID = '';
  late String phoneNumber;
  final phoneAuthRepo = PhoneAuthRepo();

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
   //receivedID = verificationId;
    MagicRouter.navigateTo(const VerifyCodeView());

    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    log('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    log(otpCode);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: CacheHelper.getData(key: 'receivedID'), smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      MagicRouter.navigateTo(const ResetPasswordView());
      emit(PhoneOTPVerified());
    } catch (error) {
      log("$error");
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  // void verifyUserPhoneNumber() {
  //   emit(Loading());
  //   auth.verifyPhoneNumber(
  //     phoneNumber: '+${selectedCountry.phoneCode}${phoneNumberController.text}',
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential).then(
  //             (value) => print('Logged In Successfully'),
  //           );
  //       phoneNumber =
  //           '+${selectedCountry.phoneCode}${phoneNumberController.text}';
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       receivedID = verificationId;
  //       // otpFieldVisibility = true;
  //       // setState(() {});
  //       MagicRouter.navigateTo(const VerifyCodeView());

  //       emit(CodeSend());
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print('TimeOut');
  //     },
  //   );
  // }

  // Future<void> verifyOTPCode(otpCode) async {
  //   emit(PhoneNumberSubmited());
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: receivedID,
  //     smsCode: otpCode,
  //   );
  //   await auth.signInWithCredential(credential).then((value) {
  //     print('User Login In Successful');
  //     MagicRouter.navigateTo(const HomeView());
  //     emit(PhoneOTPVerified());
  //   });
  // }

  Future phoneAuth() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar(
        LocaleKeys.noInternetConnectivity.tr(),
      );
    }
    emit(Loading());
    final res = await phoneAuthRepo.phoneAuth(phoneNumberController.text);
    res.fold(
      (err) async {
        emit(PhoneAuthInitial());

        showSnackBar(err);
      },
      (res) async {
        emit(PhoneAuthInitial());
        await CacheHelper.saveData(key: 'id', value: res.data.id);
        await CacheHelper.saveData(key: 'name', value: res.data.name);
        await CacheHelper.saveData(key: 'photo', value: res.data.photo);
       // await CacheHelper.saveData(key: 'email', value: res.data.email);
        await CacheHelper.saveData(key: 'lang', value: res.data.language);

        CacheHelper.saveData(key: 'lang', value: 'en');
        submitPhoneNumber();
      },
    );
  }
}
