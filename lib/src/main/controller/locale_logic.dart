import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl_standalone.dart';
//import 'package:wonders/common_libs.dart';

import 'package:wonders/src/controller.dart' show settingsLogic;
import 'package:wonders/src/view.dart';

///
AppLocalizations get $strings => localeLogic.strings;

///
LocaleLogic get localeLogic => LocaleLogic();

///
class LocaleLogic {
  ///
  factory LocaleLogic() => _this ??= LocaleLogic._();
  LocaleLogic._();
  static LocaleLogic? _this;

  ///
  AppLocalizations get strings => _strings!;
  AppLocalizations? _strings;

  ///
  bool get isLoaded => _strings != null;

  ///
  bool get isEnglish => strings.localeName == 'en';

  ///
  Future<void> load() async {
    final localeCode = await findSystemLocale();
    Locale locale = Locale(localeCode.split('_')[0]);
    //
    if (kDebugMode) {
      // Uncomment for testing in chinese
      // locale = Locale('zh');
    }
    //
    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = const Locale('en');
    }
    //
    settingsLogic.currentLocale.value = locale.languageCode;
    _strings = await AppLocalizations.delegate.load(locale);
  }

  ///
  Future<void> refreshIfChanged(Locale locale) async {
    if (_strings?.localeName != locale.languageCode &&
        AppLocalizations.supportedLocales.contains(locale)) {
      _strings = await AppLocalizations.delegate.load(locale);
    }
  }
}
