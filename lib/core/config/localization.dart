import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:rijksmuseum_app/core/util/enums/language_enum.dart';

import 'pref_manager.dart';

class CustomLocalizations{
  static final List<Locale> languages= [
    const Locale("en", "EN"),
    const Locale("nl", "NL")
  ];
  static const Locale fallBackLocale = Locale("en", "EN");

  static Locale _selectedLocale(String localeName) => localeName.toLocale();

  static int getIndexFromLocale(String localeName){
    return languages.indexOf(_selectedLocale(localeName));
  }

  static String selectLanguage(String languageCode){
    Languages lan = Languages.values
        .firstWhere((element) => element.toString() == languageCode);

    switch(lan){
      case Languages.en_EN:
        return "English";
      case Languages.nl_NL:
        return "Nederlands";
    }
  }

  static getLanguage(Languages language){
    switch (language){
      case Languages.en_EN:
        if(PrefManager().getLocale() == "en_EN") {
          return "English";
        } else {
          return "Engels";
        }
      case Languages.nl_NL:
        if(PrefManager().getLocale() == "en_EN"){
          return "Dutch";
        } else {
          return "Nederlands";
        }
    }
  }
}

