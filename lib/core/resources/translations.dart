import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sprintf/sprintf.dart';

import 'language.dart';
import 'translations_application.dart';

class Translations {
  late Locale mainLocale;
  late Locale locale;

  Translations(this.locale) {
    mainLocale = locale;
  }

  static Map<dynamic, dynamic>? _localizedValues;

  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key, {List<String>? params}) {
    if (params != null) {
      return sprintf(_localizedValues![key], params);
    }
    return _localizedValues![key] ?? key;
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = Translations(locale);
    String jsonContent = await rootBundle.loadString("assets/strings/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  Language get currentLanguage => LanguageExtensions.fromCode(locale.languageCode)!;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => app.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale? overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) =>
      overriddenLocale != null && app.supportedLanguages.contains(overriddenLocale!.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale!);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}
