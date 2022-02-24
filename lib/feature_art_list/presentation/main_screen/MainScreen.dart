import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rijksmuseum_app/core/presentation/BasePage.dart';
import 'package:rijksmuseum_app/core/util/constants/localization_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseum_app/di/AppModule.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/art_list_screen/ArtListScreen.dart';

import '../../../core/util/enums/language_enum.dart';
import 'bloc/language_bloc.dart';

class MainScreen extends BasePage {
  const MainScreen({Key? key}) : super(key: key);

  @override
  BasePageState createState() => _MainScreen();
}

class _MainScreen extends BasePageState<MainScreen> {
  late LanguageBloc _languageBloc;
  bool status = false;

  @override
  void didChangeDependencies() {
    _languageBloc = LanguageBloc(locator());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _languageBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              FlutterSwitch(
                width: 120.0,
                activeText: LC.english.tr(),
                inactiveText: LC.dutch.tr(),
                height: double.infinity,
                valueFontSize: 13.0,
                toggleSize: 30.0,
                value: _languageBloc.state.language == Languages.en_EN.name
                    ? true
                    : false,
                inactiveColor: Colors.transparent,
                showOnOff: true,
                onToggle: (val) {
                  switch (val) {
                    case true:
                      Locale locale = const Locale('en', 'EN');
                      context.setLocale(locale);
                      _languageBloc.add(ChangeLanguage(locale.toString()));
                      break;
                    case false:
                      Locale locale = const Locale('nl', 'NL');
                      context.setLocale(locale);
                      _languageBloc.add(ChangeLanguage(locale.toString()));
                      break;
                  }
                },
              )
            ],
          ),
          body:  ArtListScreen(key: UniqueKey(),),
        );
      },
    );
  }
}
