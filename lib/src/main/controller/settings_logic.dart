import 'package:flutter/foundation.dart';
//import 'package:wonders/common_libs.dart';
// import 'package:wonders/logic/common/save_load_mixin.dart';

import 'package:wonders/src/controller.dart'
    show
        AppLifecycleState,
        StateXController,
        ThrottledSaveLoadMixin,
        localeLogic,
        timelineLogic,
        wondersLogic;
import 'package:wonders/src/view.dart'
    show Locale, TargetPlatform, ValueNotifier;

///
SettingsLogic get settingsLogic => SettingsLogic();

///
class SettingsLogic extends StateXController with ThrottledSaveLoadMixin {
  ///
  factory SettingsLogic() => _this ??= SettingsLogic._();
  SettingsLogic._();
  static SettingsLogic? _this;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("SettingsLogic: This runs in State object's initState() function.");
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print("SettingsLogic: This runs in State object's dispose() function.");
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print('SettingsLogic: App is inactive.');
        }
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print('SettingsLogic: The app is paused.');
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print('SettingsLogic: Running but nothing shown.');
        }
        break;
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print('SettingsLogic: User has returned to this app.');
        }
        break;
      default:
    }
  }

  @override
  String get fileName => 'settings.dat';

  ///
  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);

  ///
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);

  ///
  late final currentLocale = ValueNotifier<String>('en')
    ..addListener(scheduleSave);

  ///
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

  ///
  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.refreshIfChanged(value);
    wondersLogic.init();
    timelineLogic.init();
  }

  /// Passed to an onPressed parameter
  Future<void> onPressed() async {
    await changeLocale(Locale(currentLocale.value == 'en' ? 'zh' : 'en'));
    setState(() {});
  }
}
