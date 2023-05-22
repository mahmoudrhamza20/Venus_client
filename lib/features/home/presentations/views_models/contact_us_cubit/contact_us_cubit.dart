import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../data/models/contact_us_model.dart';
import '../../../data/repos/contact_us_repo.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());
  final contactUsRepo = ContactUsRepo();

  static ContactUsCubit of(context) => BlocProvider.of(context);
  final msgController = TextEditingController();
  ContactUsData? contactUsData;

  Future getContactUs() async {
    emit(ContactUsLoading());
    final res = await contactUsRepo.getContactUs();
    res.fold(
      (err) {
        showSnackBar(err);
        emit(ContactUsInitial());
      },
      (res) async {
        contactUsData = res.data;
        emit(ContactUsInitial());
      },
    );
  }

  Future sendMsg() async {
    emit(SendMsgInitial());
    final res = await contactUsRepo.sentMsg(msgController.text);
    res.fold(
      (err) {
        showSnackBar(err);
        emit(SendMsgLoading());
      },
      (res) async {
        emit(SendMsgLoaded());
        CacheHelper.getData(key: 'lang') =='en'?showSnackBar('Message sent successfully') :showSnackBar('تم إرسال الرسالة بنجاح');
        msgController.clear();
      },
    );
  }
}
