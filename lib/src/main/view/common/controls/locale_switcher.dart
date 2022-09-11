// import 'package:wonders/common_libs.dart';

import 'package:wonders/src/controller.dart' show $strings, settingsLogic;
import 'package:wonders/src/view.dart';

class LocaleSwitcher extends StatelessWidget with GetItMixin {
  LocaleSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final locale = watchX((SettingsLogic s) => s.currentLocale);
    final locale = settingsLogic.currentLocale.value;

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
