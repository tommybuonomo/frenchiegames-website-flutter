import 'package:flutter/material.dart';
import 'package:frenchiegames_website/core/resources/language.dart';

typedef LocaleChangeCallback = void Function(Locale locale);

class Application {
  // List of supported languages
  final List<String> supportedLanguages = Language.values.map((e) => e.code).toList();

  // Returns the list of supported Locales
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  // Function to be invoked when changing the working language
  LocaleChangeCallback? onLocaleChanged;

  ///
  /// Internals
  ///
  static final Application _app = Application._internal();

  factory Application() {
    return _app;
  }

  Application._internal();
}

Application app = Application();
