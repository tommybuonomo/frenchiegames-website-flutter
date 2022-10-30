class AppInfo {
  final String title;
  final String desc;
  final String privacyPolicyUrl;
  final String? termsUrl;
  final String screenshotPrefix;
  final String playStoreUrl;
  final String appStoreUrl;

  AppInfo(
      {required this.title,
      required this.desc,
      required this.privacyPolicyUrl,
      this.termsUrl,
      required this.screenshotPrefix,
      required this.playStoreUrl,
      required this.appStoreUrl});

  static AppInfo linkedWordsAppInfo = AppInfo(
    title: "linked_words",
    desc: "linked_words_desc",
    privacyPolicyUrl: "linked_words_privacy_policy_url",
    screenshotPrefix: "linked_words_screenshot_prefix",
    playStoreUrl: "linked_words_play_store_url",
    appStoreUrl: "linked_words_app_store_url",
    termsUrl: "linked_words_app_terms_url",
  );

  static AppInfo nonogramAppInfo = AppInfo(
    title: "nonogram_colors",
    desc: "nonogram_colors_desc",
    privacyPolicyUrl: "nonogram_colors_privacy_policy_url",
    screenshotPrefix: "nonogram_colors_screenshot_prefix",
    playStoreUrl: "nonogram_colors_play_store_url",
    appStoreUrl: "nonogram_colors_app_store_url",
  );

  static AppInfo rippleEffectAppInfo = AppInfo(
    title: "ripple_effect",
    desc: "ripple_effect_desc",
    privacyPolicyUrl: "ripple_effect_privacy_policy_url",
    screenshotPrefix: "ripple_effect_screenshot_prefix",
    playStoreUrl: "ripple_effect_play_store_url",
    appStoreUrl: "ripple_effect_app_store_url",
  );
}
