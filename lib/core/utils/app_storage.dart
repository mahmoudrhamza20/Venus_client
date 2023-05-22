import 'package:get_storage/get_storage.dart';
import 'package:taxi/core/utils/cache_helper.dart';
import 'package:taxi/features/auth/data/models/user_model.dart';
import '../../features/auth/presentation/views/login_view.dart';
import 'magic_router.dart';

abstract class AppStorage {
  static final GetStorage _box = GetStorage();

  static Future<void> init() async => await GetStorage.init();

  static UserModel? get getUserInfo {
    if (_box.hasData('user')) return UserModel.fromJson(_box.read('user'));
    return null;
  }

  static String? get getPassword {
    if (_box.hasData('password')) return _box.read('password');
    return null;
  }

  static String? get getToken {
    if (_box.hasData('token')) return _box.read('token');
    return null;
  }

  static String get getLang {
    if (_box.hasData('language')) {
      return _box.read('language');
    }
    return 'en';
  }

  static bool get isLogged => getUserInfo != null;

  static Future<void> cacheUserInfo(UserModel userModel) =>
      _box.write('user', userModel.toJson());

  static Future<void> cacheLang(String lang) => _box.write('language', lang);

  static Future<void> cachePasswordUserInfo(String passwoed) => _box.write('password', passwoed);

  static Future<void> cacheToken(String token) => _box.write('token', token);

  static int get getUserId => getUserInfo!.data.id;

  static String get getCurrentLang => getLang;

  static String get getPasswordUserInfo => getPassword!;

  static String get getTokenInfo => getToken!;

  static UserModel get getUserData => getUserInfo!;

  static Future<void> signOut() async {
    CacheHelper.clear();
    await _box.erase();
    MagicRouter.navigateAndPopAll(const LoginView());
  }
}
