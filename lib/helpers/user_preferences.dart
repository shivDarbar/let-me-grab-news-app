import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static var _prefs;

  static const _keyUserLogin = 'userLogin';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future setuserLogin(bool userLogin) async {
    await _prefs.setBool(_keyUserLogin, userLogin);
  }

  static bool getUserLogin() {
    return _prefs.getBool(_keyUserLogin) ?? false;
  }
}
