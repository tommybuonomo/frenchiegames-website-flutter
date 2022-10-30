import 'package:flutter/material.dart';
import 'package:frenchiegames_website/core/platform/extension/context_extensions.dart';

import '../../resources/app_colors.dart';
import 'hover_text.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;

  const AppScaffold({required this.child, Key? key}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          widget.child,
          Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.background, Colors.transparent],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HoverText(
                          text: context.text("header_our_games"),
                          style: context.textTheme.subtitle1,
                          onTap: () {},
                          underline: true,
                        ),
                        SizedBox(width: screenSize.width / 20),
                        HoverText(
                          text: context.text("header_contact_us"),
                          style: context.textTheme.subtitle1,
                          onTap: () {},
                          underline: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
