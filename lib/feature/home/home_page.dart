import 'package:flutter/material.dart';
import 'package:frenchiegames_website/core/platform/extension/context_extensions.dart';
import 'package:frenchiegames_website/core/platform/util/responsive_provider.dart';
import 'package:frenchiegames_website/core/platform/widget/app_scaffold.dart';
import 'package:frenchiegames_website/core/resources/app_resources.dart';

import '../../core/resources/app_colors.dart';

class HomePage extends StatefulWidget {
  static const route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _pageOffset = 1.0;
  ResponsiveProvider<PageController> pageControllerProvider = ResponsiveProvider(
      large: PageController(viewportFraction: 0.15, initialPage: 1),
      medium: PageController(viewportFraction: 0.2, initialPage: 1),
      small: PageController(viewportFraction: 0.3, initialPage: 1));

  @override
  void initState() {
    pageControllerProvider.all().forEach((controller) {
      controller.addListener(() {
        setState(() {
          _pageOffset = controller.page ?? 1.0;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        child: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildContent(),
          ],
        ),
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
        Center(
          child: Container(
            height: headerHeight,
            alignment: Alignment.center,
            width: context.sw * 0.2,
            constraints: BoxConstraints(
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

  _buildContent() {
    var items = [
      _buildAppIconCard(AppResources.rippleEffectIcon, context.text("ripple_effect")),
      _buildAppIconCard(AppResources.linkedWordsIcon, context.text("linked_words")),
      _buildAppIconCard(AppResources.nonogramIcon, context.text("nonogram_colors"))
    ];
    return Transform.translate(
      offset: Offset(0, -100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            child: PageView.builder(
              itemCount: 3,
              controller: pageControllerProvider.get(context),
              itemBuilder: (context, index) {
                var currentIndexOffset = 1.0 - (index - _pageOffset).abs().clamp(0.0, 1.0);
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        pageControllerProvider
                            .get(context)
                            .animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                      },
                      child: Transform.translate(
                          offset: Offset(0, -currentIndexOffset * 20),
                          child: Transform.scale(scale: 1.0 + currentIndexOffset * 0.2, child: items[index]))),
                );
              }, // set ImageCardItem or IconTitleCardItem class
            ),
          ),
          Container(
            height: 800,
          )
        ],
      ),
    );
  }

  _buildAppIconCard(String icon, String text) {
    return Container(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.network(
              icon,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: context.textTheme.subtitle2,
              ))
        ],
      ),
    );
  }
}
