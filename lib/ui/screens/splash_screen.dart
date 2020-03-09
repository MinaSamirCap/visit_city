import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';
import '../../ui/screens/sign_in_screen.dart';
import '../../res/sizes.dart';
import '../../ui/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const ROUTE_NAME = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// to start time to switch to another screen
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Coolor.BLUE_APP,
      child: SizedBox(
        height: Sizes.SIZE_75,
        child: Center(
            child: Image.asset(
          AssPath.LOGO_WHITE,
          width: Sizes.SIZE_300,
        )),
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
    final prefs = await SharedPreferences.getInstance();
    final isLogedIn = prefs.getBool('isLogedIn');
    if (isLogedIn != null) {
      isLogedIn
          ? Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME)
          : Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
    } else {
      Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
    }
  }
}
