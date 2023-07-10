import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wonders/src/controller.dart';

import 'package:wonders/src/view.dart';

/// The WonderApp
class WondersApp extends AppStatefulWidget {
  /// No progress indicator while starting up.
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
        inInitState: () {
          // Collectibles
          GetIt.I
              .registerLazySingleton<CollectiblesLogic>(CollectiblesLogic.new);
          // Add a listener for when the locale changes
          settingsLogic.currentLocale.addListener(() {
            App.locale = Locale(settingsLogic.currentLocale.value);
            // Calls the MaterialApp again.
            App.setState(() {});
          });
        },
        locale: Locale(settingsLogic.currentLocale.value),
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.routerDelegate,
        routeInformationProvider: appRouter.routeInformationProvider,
        routeInformationParser: appRouter.routeInformationParser,
        builder: (_, child) => WondersAppScaffold(child: child!),
        theme: ThemeData(fontFamily: $styles.text.body.fontFamily),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );

  /// An alternate approach would be to have the State object as a separate class
  // @override
  // AppState createAppState() => WondersAppState();
}

/// An alternate approach would be to have the State object as a separate class
// /// App's State object
// class WondersAppState extends AppState<WondersApp> {
//   /// Assign the appropriate values.
//   WondersAppState()
//       : super(
//           locale: Locale(settingsLogic.currentLocale.value),
//           debugShowCheckedModeBanner: false,
//           routerDelegate: appRouter.routerDelegate,
//           routeInformationProvider: appRouter.routeInformationProvider,
//           routeInformationParser: appRouter.routeInformationParser,
//           theme: ThemeData(fontFamily: $styles.text.body.fontFamily),
//           localizationsDelegates: const [
//             AppLocalizations.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: AppLocalizations.supportedLocales,
//         );
//
//   @override
//   Future<bool> initAsync() async {
//     await super.initAsync();
//     await appLogic.bootstrap();
//     return true;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     return settingsLogic.currentLocale.addListener(() {
//       App.locale = Locale(settingsLogic.currentLocale.value);
//     });
//   }
// }

/// An alternate approach would be to have the State object as a separate class
/// and all its options set from separate functions.
// class WondersAppState extends AppState<WondersApp> {
//   @override
//   Future<bool> initAsync() async {
//     await super.initAsync();
//     await appLogic.bootstrap();
//     return true;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     return settingsLogic.currentLocale.addListener(() {
//       App.locale = Locale(settingsLogic.currentLocale.value);
//     });
//   }
//
//   @override
//   Locale onLocale() => Locale(settingsLogic.currentLocale.value);
//
//   @override
//   bool onDebugShowCheckedModeBanner() => false;
//
//   @override
//   RouterDelegate<Object> onRouterDelegate() => appRouter.routerDelegate;
//
//   @override
//   RouteInformationProvider onRouteInformationProvider() =>
//       appRouter.routeInformationProvider;
//
//   @override
//   RouteInformationParser<Object> onRouteInformationParser() =>
//       appRouter.routeInformationParser;
//
//   @override
//   ThemeData onTheme() => ThemeData(fontFamily: $styles.text.body.fontFamily);
//
//   @override
//   List<LocalizationsDelegate<dynamic>> onLocalizationsDelegates() {
//     super.onLocalizationsDelegates();
//     return const [
//       AppLocalizations.delegate,
//       GlobalMaterialLocalizations.delegate,
//       GlobalWidgetsLocalizations.delegate,
//       GlobalCupertinoLocalizations.delegate,
//     ];
//   }
//
//   @override
//   List<Locale> onSupportedLocales() => AppLocalizations.supportedLocales;
// }
