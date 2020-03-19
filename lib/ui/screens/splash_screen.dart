import 'dart:async';

import 'package:flutter/material.dart';
import '../../prefs/pref_manager.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';
import '../../ui/screens/sign_in_screen.dart';
import '../../res/sizes.dart';
import '../../ui/screens/home_screen.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';

class SplashScreen extends StatefulWidget {
  static const ROUTE_NAME = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppLocalizations _appLocal;
  @override
  void initState() {
    super.initState();

    /// to start time to switch to another screen
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        color: Coolor.BLUE_APP,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            SizedBox(
              height: Sizes.SIZE_75,
              child: Center(
                child: Image.asset(
                  AssPath.LOGO_WHITE,
                  width: Sizes.SIZE_300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                right: 10,
                left: 10,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(),
                    Text(
                      _appLocal.translate(LocalKeys.DEVELOPED_BY),
                      style: TextStyle(
                          color: Coolor.WHITE,
                          fontSize: 15,
                          fontFamily: 'Arial',
                          fontStyle: FontStyle.italic),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  /// time to switch with dummy screen
  startTime() async {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration, navigationPage);
  }

  /// navigate with dummy screen
  Future navigationPage() async {
    final isLogedIn = await PrefManager.isLogedIn();
    if (isLogedIn != null) {
      isLogedIn
          ? Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME)
          : Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
    } else {
      Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
    }
  }
}
