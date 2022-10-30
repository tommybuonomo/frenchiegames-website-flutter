import 'package:flutter/material.dart';
import 'package:frenchiegames_website/feature/home/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (context) {
          return const HomePage();
        });
    }
  }
}
