enum Language { FR, EN }

extension LanguageExtensions on Language {
  static Language? fromCode(languageString) {
    return languageString == null
        ? null
        : languageString == "fr"
        ? Language.FR
        : Language.EN;
  }

  String get code {
    return this == Language.FR ? "fr" : "en";
  }
}