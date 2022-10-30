import 'package:flutter/cupertino.dart';
import 'package:frenchiegames_website/core/platform/extension/context_extensions.dart';

class ResponsiveProvider<T> {
  final T? small;
  final T? medium;
  final T large;

  ResponsiveProvider({required this.large, this.medium, this.small});

  T get(BuildContext context) {
    var screenWidth = context.sw;
    if (screenWidth >= 1200) {
      return large;
    } else if (screenWidth >= 800) {
      return medium ?? large;
    } else {
      return small ?? medium ?? large;
    }
  }

  List<T> all() {
    List<T> listOfNotNull = [];
    if (small != null) listOfNotNull.add(small!);
    if (medium != null) listOfNotNull.add(medium!);
    listOfNotNull.add(large);
    return listOfNotNull;
  }
}
