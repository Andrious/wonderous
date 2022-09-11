import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wonders/src/controller.dart';

import 'package:wonders/src/view.dart';

class WondersApp extends AppStatefulWidget {
  WondersApp({
    super.key,
    super.circularProgressIndicator = false,
  });

  @override
  AppState createAppState() => AppState<WondersApp>(
        inInitAsync: () async {
          await appLogic.bootstrap();
          return true;
        },
        inInitState: () => settingsLogic.currentLocale.addListener(() {
          App.locale = Locale(settingsLogic.currentLocale.value);
        }),
        locale: Locale(settingsLogic.currentLocale.value),
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.routerDelegate,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        theme: ThemeData(fontFamily: $styles.text.body.fontFamily),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
}
