import 'dart:convert';

import '../models/rate/user_model.dart';
import '../prefs/pref_keys.dart';
import '../prefs/pref_util.dart';

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

  static Future<void> setIsGuest(bool isGuest) async {
    await PrefUtils.setBool(PrefKeys.IS_GUEST, isGuest);
  }

  static Future<bool> isGuest() async {
    return await PrefUtils.getBool(PrefKeys.IS_GUEST);
  }

  static Future<void> setLang(String locale) async {
    return await PrefUtils.setString(PrefKeys.LANG, locale);
  }

  static Future<String> getLang() async {
    return await PrefUtils.getString(PrefKeys.LANG);
  }

  static Future<void> setUser(UserModel user) async {
    await PrefUtils.setString(PrefKeys.USER, json.encode(user.toJson()));
  }

  static Future<UserModel> getUser() async {
    return UserModel.fromJson(
        json.decode(await PrefUtils.getString(PrefKeys.USER)));
  }

  static Future<void> clearAllData() async {
    await PrefUtils.clearData();
  }
}
