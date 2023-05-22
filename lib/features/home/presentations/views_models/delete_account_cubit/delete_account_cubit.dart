import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/utils/cache_helper.dart';
import '../../../../../core/utils/magic_router.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../auth/presentation/views/login_view.dart';
import '../../../data/repos/delete_account_repo.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  static DeleteAccountCubit of(context) => BlocProvider.of(context);
  final deleteAccount = DeleteAccountRepo();

  Future delete() async {
    emit(DeleteAccountLoading());
    final res = await deleteAccount.deleteAccount();
    res.fold(
          (err) {
        showSnackBar(err);
        emit(DeleteAccountInitial());
      },
          (res) async {
             showSnackBar( CacheHelper.getData(key: 'lang') !='en'
                  ? res.message:'Account was deleted');
          //  await AppStorage.signOut();
            CacheHelper.clear();
            MagicRouter.navigateAndPopAll(const LoginView());
            showSnackBar(res.message);
          emit(DeleteAccountInitial());
      },
    );
  }
}
