import 'package:visit_city/prefs/pref_keys.dart';
import 'package:visit_city/prefs/pref_util.dart';

class PrefManager {
  static Future<void> setToken(String token) async {
    await PrefUtils.setString(PrefKeys.TOKEN, token);
  }

  static Future<String> getToken() async {
    return await PrefUtils.getString(PrefKeys.TOKEN);
  }

  static Future<void> setLogedIn() async {
    await PrefUtils.setBool(PrefKeys.IS_LOGED_IN, true);
  }

  static Future<bool> isLogedIn() async {
    return await PrefUtils.getBool(PrefKeys.IS_LOGED_IN);
  }

  static Future<void> setLang(String locale) async {
    return await PrefUtils.setString(PrefKeys.LANG, locale);
  }

  static Future<String> getLang() async {
    return await PrefUtils.getString(PrefKeys.LANG);
  }

  static Future<void> clearAllData() async {
    await PrefUtils.clearData();
  }
}
