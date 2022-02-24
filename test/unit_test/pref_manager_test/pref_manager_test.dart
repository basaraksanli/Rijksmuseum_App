import 'package:flutter_test/flutter_test.dart';
import 'package:rijksmuseum_app/core/config/pref_manager.dart';

void main() {

  group("Pref Manager tests", (){
    BasePref basePref = PrefManager();
    test("Pref Manager Test", (){
      basePref.setLocale("en_EN");
      expect(basePref.getLocale(), "en_EN");
      expect(basePref.getLanguageCode(), "en" );
      basePref.setLocale("nl_NL");
      expect(basePref.getLocale(), "nl_NL");
      expect(basePref.getLanguageCode(), "nl" );
    });
  });
}