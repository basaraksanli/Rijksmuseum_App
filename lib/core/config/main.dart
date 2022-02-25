import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rijksmuseum_app/di/app_module.dart';
import 'package:rijksmuseum_app/feature_art_list/presentation/main_screen/main_screen.dart';

import 'localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupDi();

  runApp(EasyLocalization(
    supportedLocales: CustomLocalizations.languages,
    path: 'assets/translations',
    fallbackLocale: CustomLocalizations.fallBackLocale,
    child: const RijksMuseumApp(
      homePage: MainScreen(),
    ),
  ));
}
class RijksMuseumApp extends StatelessWidget {
  final Widget? homePage;

  const RijksMuseumApp({Key? key, this.homePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: homePage,
    );
  }
}






