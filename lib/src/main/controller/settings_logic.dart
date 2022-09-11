import 'package:flutter/foundation.dart';
//import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/common/save_load_mixin.dart';

import 'package:wonders/src/controller.dart'
    show ThrottledSaveLoadMixin, localeLogic, timelineLogic, wondersLogic;
import 'package:wonders/src/view.dart'
    show Locale, TargetPlatform, ValueNotifier;

SettingsLogic get settingsLogic => SettingsLogic();

class SettingsLogic with ThrottledSaveLoadMixin {
  factory SettingsLogic() => _this ??= SettingsLogic._();
  SettingsLogic._();
  static SettingsLogic? _this;

  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final currentLocale = ValueNotifier<String>('en')
    ..addListener(scheduleSave);

  final bool useBlurs = defaultTargetPlatform != TargetPlatform.android;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    hasDismissedSearchMessage.value =
        value['hasDismissedSearchMessage'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'hasDismissedSearchMessage': hasDismissedSearchMessage.value,
    };
  }

  Future<void> setLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.refreshIfChanged(value);
    wondersLogic.init();
    timelineLogic.init();
  }
}
