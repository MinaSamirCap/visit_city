import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visit_city/apis/api_manager.dart';
import 'package:visit_city/ui/screens/sign_in_screen.dart';
import 'package:visit_city/ui/screens/splash_screen.dart';

class StartScreen extends StatelessWidget {
  static const ROUTE_NAME = '/start';

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiManager>(builder: (ctx, appManager, _) {
      print("StarterScreen: ${appManager.mustLogout}");
      return appManager.mustLogout ? SignInScreen() : SplashScreen();
    });
  }
}
