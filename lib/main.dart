import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visit_city/ui/screens/signIn_screen.dart';

import './ui/screens/home_screen.dart';
import './ui/screens/splash_screen.dart';
import './utils/lang/app_localization.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),

      /// the list of our supported locals for our app
      /// currently we support only 2 English and Arabic ...
      supportedLocales: [Locale(CODE_EN, CON_US), Locale(CODE_AR, CON_EG)],

      /// these delegates make sure that the localization data for the proper
      /// language is loaded ...
      localizationsDelegates: [
        /// A class which loads the translations from JSON files
        AppLocalizations.delegate,

        /// Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,

        /// Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],

      /// Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        /// Check if the current device locale is in our supported locales list
        /// That we added previously --> supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],

        for (var localItem in supportedLocales) {
          if (localItem.languageCode == locale.languageCode &&
              localItem.countryCode == locale.countryCode) {
            return localItem;
          }
        }

        /// If the locale of the device is not supported, use the first one
        /// from the list (English, in this case).
        return supportedLocales.first;
      },
      home: SplashScreen(),
      routes: {
        HomeScreen.ROUTE_NAME: (ctx) => HomeScreen(),
        SignInScreen.ROUTE_NAME: (ctx) => SignInScreen(),
      },
    );
  }
}
