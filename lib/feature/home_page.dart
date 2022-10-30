import 'package:flutter/widgets.dart';
import 'package:frenchiegames_website/core/platform/widget/app_scaffold.dart';

class HomePage extends StatefulWidget {
  static const route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Container()
    );
  }
}
