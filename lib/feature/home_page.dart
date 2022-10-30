import 'package:flutter/material.dart';
import 'package:frenchiegames_website/core/platform/extension/context_extensions.dart';
import 'package:frenchiegames_website/core/platform/widget/app_scaffold.dart';
import 'package:frenchiegames_website/core/resources/app_resources.dart';

import '../core/resources/app_colors.dart';

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
        child: Container(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  _buildHeader() {
    var headerHeight = context.sh * 0.75;
    return Stack(
      children: [
        Container(
            height: headerHeight,
            width: double.infinity,
            child: Image.network(
              AppResources.banner,
              fit: BoxFit.cover,
            )),
        Container(
          height: headerHeight + 1, // bug where 1 pixel is not gradient...
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.background.withOpacity(0.5), AppColors.background],
                stops: [0.0, 0.5, 1.0]),
          ),
        ),
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
        Center(
          child: Container(
            height: headerHeight,
            alignment: Alignment.center,
            width: context.sw * 0.2,
            constraints: new BoxConstraints(
              minWidth: 200.0,
              maxWidth: 400.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  AppResources.frenchieGamesHeader,
                  isAntiAlias: true,
                  fit: BoxFit.contain,
                ),
                Image.network(
                  AppResources.baguette,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
