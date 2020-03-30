import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'apis/auth_api_manager.dart';
import 'ui/screens/qr_code_screen.dart';
import 'ui/screens/sight_details_screen.dart';
import 'ui/screens/wishlist_screen.dart';
import 'res/coolor.dart';
import 'utils/lang/app_localization.dart';
import 'apis/api_manager.dart';
import 'ui/screens/explore_details_screen.dart';
import 'ui/screens/itinerary_details_screen.dart';
import 'ui/screens/sign_in_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/forget_password_screen.dart';
import 'ui/screens/feedback_screen.dart';
import 'ui/widget/map_widget.dart';
import 'ui/screens/useful_contacts_screen.dart';
import 'ui/screens/mixed_itineraries_screen.dart';
import 'ui/screens/how_to_use_app_screen.dart';
import 'ui/screens/fayoum_intro_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/profile_update_screen.dart';
import 'ui/screens/reset_password_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: ApiManager(),


        
      ),
      ChangeNotifierProvider.value(
        value: AuthApiManager(),
      ),
    ], child: visitFayoumApp());
  }

  MaterialApp visitFayoumApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Coolor.PRIMARYSWATCH),

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

        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],

      /// Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        /// Check if the current device locale is in our supported locales list
        /// That we added previously --> supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
        if(locale==null){
          return supportedLocales.first;

        }
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
        SplashScreen.ROUTE_NAME: (ctx) => SplashScreen(),
        HomeScreen.ROUTE_NAME: (ctx) => HomeScreen(),
        SignInScreen.ROUTE_NAME: (ctx) => SignInScreen(),
        SignUpScreen.ROUTE_NAME: (ctx) => SignUpScreen(),
        ForgetPasswordScreen.ROUTE_NAME: (ctx) => ForgetPasswordScreen(),
        FeedbackScreen.ROUTE_NAME: (ctx) => FeedbackScreen(),
        ItineraryDetailsScreen.ROUTE_NAME: (ctx) => ItineraryDetailsScreen(),
        ExploreDetailsScreen.ROUTE_NAME: (ctx) => ExploreDetailsScreen(),
        SightDetailsScreen.ROUTE_NAME: (ctx) => SightDetailsScreen(),
        MapWidget.ROUTE_NAME: (ctx) => MapWidget(),
        WishlistScreen.ROUTE_NAME: (ctx) => WishlistScreen(),
        QrCodeScreen.ROUTE_NAME: (ctx) => QrCodeScreen(),
        ProfileScreen.ROUTE_NAME: (ctx) => ProfileScreen(),
        UsefulContactsScreen.ROUTE_NAME: (ctx) => UsefulContactsScreen(),
        MixedItinerariesScreen.ROUTE_NAME: (ctx) => MixedItinerariesScreen(),
        FayoumIntroScreen.ROUTE_NAME: (ctx) => FayoumIntroScreen(),
        HowToUseAppScreen.ROUTE_NAME: (ctx) => HowToUseAppScreen(),
        ProfileUpdateScreen.ROUTE_NAME: (ctx) => ProfileUpdateScreen(),
        ResetPasswordScreen.ROUTE_NAME: (ctx) => ResetPasswordScreen(),
      },
    );
  }

}
