import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/resources/app_colors.dart';
import 'core/resources/translations.dart';
import 'core/resources/translations_application.dart';
import 'core/route_generator.dart';

void main() {
  runApp(const FrenchieGamesApp());
}

class FrenchieGamesApp extends StatefulWidget {
  const FrenchieGamesApp({super.key});

  @override
  State<FrenchieGamesApp> createState() => _FrenchieGamesAppState();
}

class _FrenchieGamesAppState extends State<FrenchieGamesApp> {
  late SpecificLocalizationDelegate _localeOverrideDelegate;

  onLocaleChange(Locale locale) {
    if (_localeOverrideDelegate.overriddenLocale != locale) {
      print("Locale should be updated with $locale");
      setState(() {
        _localeOverrideDelegate = SpecificLocalizationDelegate(locale);
      });
    }
  }

  @override
  void initState() {
    _localeOverrideDelegate = const SpecificLocalizationDelegate(null);
    app.onLocaleChanged = onLocaleChange;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final defaultTextStyle =
        TextStyle(fontSize: 16, fontFamily: "dosis", color: Colors.white, fontWeight: FontWeight.w500);
    return MaterialApp(
      title: 'Frenchie Games',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: AppColors.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: defaultTextStyle.copyWith(fontSize: 96, fontWeight: FontWeight.w900),
            headline2: defaultTextStyle.copyWith(fontSize: 60, fontWeight: FontWeight.w900),
            headline3: defaultTextStyle.copyWith(fontSize: 48, fontWeight: FontWeight.w900),
            headline4: defaultTextStyle.copyWith(fontSize: 34, fontWeight: FontWeight.w900),
            headline5: defaultTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w900),
            headline6: defaultTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            bodyText1: defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            bodyText2: defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            subtitle1: defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            subtitle2: defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
          )),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: app.supportedLocales(),
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    );
  }
}
