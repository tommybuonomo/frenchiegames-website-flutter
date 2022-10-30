import 'package:flutter/material.dart';
import 'package:frenchiegames_website/core/resources/translations.dart';

extension ContextExtensions on BuildContext {
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  double get sw {
    return MediaQuery.of(this).size.width;
  }

  double get sh {
    return MediaQuery.of(this).size.height;
  }

  String text(String key, {List<String>? params}) {
    return Translations.of(this)!.text(key);
  }
}
