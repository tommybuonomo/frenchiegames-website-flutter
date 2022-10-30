import 'package:flutter/widgets.dart';

import '../../resources/translations.dart';

class TText extends Text {
  final bool uppercase;

  TText(
    BuildContext context,
    String textKey, {
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    List<String>? params,
    this.uppercase = false,
  }) : super(
          uppercase
              ? Translations.of(context)!.text(textKey, params: params).toUpperCase()
              : Translations.of(context)!.text(textKey, params: params),
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
        );
}
