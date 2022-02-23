import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/constants/pref_constants.dart';

abstract class BasePref {
  Future<void> setLocale(String language);

  String getLocale();

  String getLanguageCode();
}

class PrefManager implements BasePref {
  static final PrefManager _instance = PrefManager._privateConstructor();

  factory PrefManager() {
    return _instance;
  }

  late SharedPreferences _prefs;

  PrefManager._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) => _prefs = prefs);
  }

  @override
  String getLocale() {
    return _prefs.getString(PrefConstants.languagePref) ?? "en_EN";
  }

  @override
  String getLanguageCode() {
    String locale = _prefs.getString(PrefConstants.languagePref) ?? "en_EN";
    return locale == "en_EN" ? "en" : "nl";
  }

  @override
  Future<void> setLocale(String language) async {
    _prefs.setString(PrefConstants.languagePref, language);
  }
}
