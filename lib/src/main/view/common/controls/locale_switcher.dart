// import 'package:wonders/common_libs.dart';

import 'package:wonders/src/controller.dart'
    show $strings, StateListener, SettingsLogic;
import 'package:wonders/src/view.dart';

///
class LocaleSwitcher extends StatefulWidget {
  ///
  const LocaleSwitcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LocaleSwitcherState();
}

// class _LocaleSwitcherState extends StateX<LocaleSwitcher> {
//   /// Pass to constructor, so the controller can call the setState() function.
//   _LocaleSwitcherState() : super(SettingsLogic()) {
//     con = controller! as SettingsLogic;
//   }
//   late SettingsLogic con;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBtn.from(
//         padding: EdgeInsets.symmetric(
//             vertical: $styles.insets.sm, horizontal: $styles.insets.sm),
//         text: $strings.localeSwapButton,
//         onPressed: con.onPressed);
//   }
// }

class _LocaleSwitcherState extends StateX<LocaleSwitcher> {
  /// Pass to constructor, so the controller can call the setState() function.
  _LocaleSwitcherState() : super(controller: SettingsLogic());

  @override
  void initState() {
    con = SettingsLogic();
    super.initState();
  }

  late SettingsLogic con;

  @override
  Widget buildAndroid(BuildContext context) {
    return AppBtn.from(
        padding: EdgeInsets.symmetric(
            vertical: $styles.insets.sm, horizontal: $styles.insets.sm),
        text: $strings.localeSwapButton,
        onPressed: con.onPressed);
  }

  @override
  Widget buildiOS(BuildContext context) => buildAndroid(context);
}

// class _LocaleSwitcherState extends StateX<LocaleSwitcher> {
//   /// Pass to constructor, so the controller can call the setState() function.
//   _LocaleSwitcherState() : super(SettingsLogic());
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBtn.from(
//         padding: EdgeInsets.symmetric(
//             vertical: $styles.insets.sm, horizontal: $styles.insets.sm),
//         text: $strings.localeSwapButton,
//         onPressed: SettingsLogic().onPressed);
//   }
// }
