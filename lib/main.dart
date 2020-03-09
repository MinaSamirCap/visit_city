import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'ui/screens/qr_code_screen.dart';
import 'ui/screens/sight_details_screen.dart';
import 'ui/screens/wishlist_screen.dart';
import 'res/coolor.dart';
import 'utils/lang/app_localization.dart';
import 'apis/api_manager.dart';
import 'apis/auth.dart';
import 'ui/screens/explore_details_screen.dart';
import 'ui/screens/itinerary_details_screen.dart';
import 'ui/screens/sign_in_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/forget_password_screen.dart';
import 'ui/screens/feedback_screen.dart';
import 'ui/widget/map_widget.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/useful_contacts_screen.dart';
import 'ui/screens/mixed_itineraries_screen.dart';
import 'ui/screens/how_to_use_app_screen.dart';
import 'ui/screens/fayoum_intro_screen.dart';
import 'ui/screens/profile_update_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: ApiManager(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
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
          home: auth.isAuth ? HomeScreen() : SplashScreen(),
          // auth.isAuth
          //     ? HomeScreen()
          //     : FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (context, authResultSnapshopt) =>
          //             authResultSnapshopt.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashScreen()
          //                 : SignInScreen(),
          //       ),
          routes: {
            SplashScreen.ROUTE_NAME: (ctx) => SplashScreen(),
            HomeScreen.ROUTE_NAME: (ctx) => HomeScreen(),
            SignInScreen.ROUTE_NAME: (ctx) => SignInScreen(),
            SignUpScreen.ROUTE_NAME: (ctx) => SignUpScreen(),
            ForgetPasswordScreen.ROUTE_NAME: (ctx) => ForgetPasswordScreen(),
            FeedbackScreen.ROUTE_NAME: (ctx) => FeedbackScreen(),
            ItineraryDetailsScreen.ROUTE_NAME: (ctx) =>
                ItineraryDetailsScreen(),
            ExploreDetailsScreen.ROUTE_NAME: (ctx) => ExploreDetailsScreen(),
            SightDetailsScreen.ROUTE_NAME: (ctx) => SightDetailsScreen(),
            MapWidget.ROUTE_NAME: (ctx) => MapWidget(),
            WishlistScreen.ROUTE_NAME: (ctx) => WishlistScreen(),
            QrCodeScreen.ROUTE_NAME: (ctx) => QrCodeScreen(),
            // ProfileScreen.ROUTE_NAME: (ctx) => ProfileScreen(),
            UsefulContactsScreen.ROUTE_NAME: (ctx) => UsefulContactsScreen(),
            MixedItinerariesScreen.ROUTE_NAME: (ctx) => MixedItinerariesScreen(),
            FayoumIntroScreen.ROUTE_NAME: (ctx) => FayoumIntroScreen(),
            HowToUseAppScreen.ROUTE_NAME: (ctx) => HowToUseAppScreen(),
            // ProfileUpdateScreen.ROUTE_NAME: (ctx) => ProfileUpdateScreen(),
          },
        ),
      ),
    );
  }
}
