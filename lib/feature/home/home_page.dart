import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frenchiegames_website/core/platform/extension/context_extensions.dart';
import 'package:frenchiegames_website/core/platform/util/responsive_provider.dart';
import 'package:frenchiegames_website/core/platform/widget/app_scaffold.dart';
import 'package:frenchiegames_website/core/platform/widget/hover_text.dart';
import 'package:frenchiegames_website/core/resources/app_resources.dart';

import '../../core/platform/widget/translation_text.dart';
import '../../core/resources/app_colors.dart';
import 'model/app_info.dart';

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
    return Transform.translate(
      offset: Offset(0, -100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildAppIconsPager(), _buildAppContents()],
      ),
    );
  }

  Widget _buildAppContents() {
    var appInfoList = [AppInfo.rippleEffectAppInfo, AppInfo.linkedWordsAppInfo, AppInfo.nonogramAppInfo];
    var appInfoIndex = _pageOffset.round();
    var appInfo = appInfoList[appInfoIndex];
    var opacity = 1.0 - ((_pageOffset - appInfoIndex) * 2).abs();
    var responsiveAppContent = ResponsiveLazyProvider(
        large: () => _buildLargeAppContent(appInfo), medium: () => _buildMediumAppContent(appInfo));
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: responsiveAppContent.get(context),
      ),
    );
  }

  Widget _buildLargeAppContent(AppInfo appInfo) {
    return Row(
      children: [
        Expanded(flex: 4, child: _buildContentAppInfo(appInfo)),
        Expanded(flex: 6, child: _buildContentScreenshots(appInfo))
      ],
    );
  }

  Widget _buildMediumAppContent(AppInfo appInfo) {
    return Column(
      children: [
        _buildTitle(appInfo),
        SizedBox.fromSize(size: Size.fromHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: _buildStoreBadge(appInfo.playStoreUrl, AppResources.playStoreBadge, byWidth: false)),
            SizedBox.fromSize(size: Size(20, 1)),
            Flexible(child: _buildStoreBadge(appInfo.appStoreUrl, AppResources.appStoreBadge, byWidth: false)),
          ],
        ),
        SizedBox.fromSize(size: Size.fromHeight(20)),
        _buildContentScreenshots(appInfo),
        SizedBox.fromSize(size: Size.fromHeight(20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: _buildDesc(appInfo, textAlign: TextAlign.center),
        ),
        SizedBox.fromSize(size: Size.fromHeight(100)),
        _buildCondition(appInfo, "privacy_policy", appInfo.privacyPolicyUrl),
        SizedBox.fromSize(size: Size.fromHeight(15)),
        appInfo.termsUrl == null ? Container() : _buildCondition(appInfo, "terms", appInfo.termsUrl!),
      ],
    );
  }

  Widget _buildContentScreenshots(AppInfo appInfo) {
    var prefix = context.text(appInfo.screenshotPrefix);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildScreenshot("assets/assets/images/${prefix}1.png"),
          _buildScreenshot("assets/assets/images/${prefix}2.png"),
          _buildScreenshot("assets/assets/images/${prefix}3.png"),
        ],
      ),
    );
  }

  _buildScreenshot(String screenshot) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.network(screenshot),
      ),
    );
  }

  Column _buildContentAppInfo(AppInfo appInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(appInfo),
        SizedBox.fromSize(size: Size.fromHeight(20)),
        _buildDesc(appInfo),
        SizedBox.fromSize(size: Size.fromHeight(20)),
        _buildStoreBadge(appInfo.playStoreUrl, AppResources.playStoreBadge),
        _buildStoreBadge(appInfo.appStoreUrl, AppResources.appStoreBadge),
        SizedBox.fromSize(size: Size.fromHeight(20)),
        _buildCondition(appInfo, "privacy_policy", appInfo.privacyPolicyUrl),
        SizedBox.fromSize(size: Size.fromHeight(8)),
        appInfo.termsUrl == null ? Container() : _buildCondition(appInfo, "terms", appInfo.termsUrl!),
      ],
    );
  }

  HoverText _buildCondition(AppInfo appInfo, String condition, String url) {
    return HoverText(
      text: context.text(condition),
      onTap: () => _openUrl(context.text(url)),
      style: context.textTheme.subtitle1,
    );
  }

  TText _buildDesc(AppInfo appInfo, {TextAlign? textAlign}) {
    return TText(
      context,
      appInfo.desc,
      style: context.textTheme.headline6,
      textAlign: textAlign,
    );
  }

  TText _buildTitle(AppInfo appInfo) {
    return TText(
      context,
      appInfo.title,
      style: context.textTheme.headline3,
    );
  }

  _buildStoreBadge(String url, String badge, {bool byWidth = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => _openUrl(context.text(url)),
              child: Container(
                  constraints: BoxConstraints(
                    maxWidth: byWidth ? 300 : double.infinity,
                    maxHeight: byWidth ? double.infinity : 80,
                  ),
                  child: Image.network(badge)))),
    );
  }

  Container _buildAppIconsPager() {
    var items = [
      _buildAppIconCard(AppResources.rippleEffectIcon, context.text("ripple_effect")),
      _buildAppIconCard(AppResources.linkedWordsIcon, context.text("linked_words")),
      _buildAppIconCard(AppResources.nonogramIcon, context.text("nonogram_colors"))
    ];
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        controller: pageControllerProvider.get(context),
        itemBuilder: (context, index) {
          var currentIndexOffset = 1.0 - (index - _pageOffset).abs().clamp(0.0, 1.0);
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () {
                  pageControllerProvider
                      .get(context)
                      .animateToPage(index, duration: Duration(milliseconds: 700), curve: Curves.decelerate);
                },
                child: Transform.translate(
                    offset: Offset(0, -currentIndexOffset * 20),
                    child: Transform.scale(scale: 1.0 + currentIndexOffset * 0.2, child: items[index]))),
          );
        }, // set ImageCardItem or IconTitleCardItem class
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

  _openUrl(url) {
    js.context.callMethod("open", [url]);
  }
}
