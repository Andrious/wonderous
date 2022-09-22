// import 'package:wonders/common_libs.dart';

import 'package:wonders/src/controller.dart' show $strings, settingsLogic;
import 'package:wonders/src/view.dart';

///
class LocaleSwitcher extends StatelessWidget {
  // with GetItMixin {
  ///
  const LocaleSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final locale = watchX((SettingsLogic s) => s.currentLocale);
    final locale = settingsLogic.currentLocale.value;
    // Link a dependency to the App's InheritedWidget.
    App.dependOnInheritedWidget(context);
    // Function defined in a function?? Never seen that before.
    Future<void> handleSwapLocale() async {
      final newLocale = Locale(locale == 'en' ? 'zh' : 'en');
      await settingsLogic.setLocale(newLocale);
    }

    return AppBtn.from(
        padding: EdgeInsets.symmetric(
            vertical: $styles.insets.sm, horizontal: $styles.insets.sm),
        text: $strings.localeSwapButton,
        onPressed: handleSwapLocale);
  }
}
