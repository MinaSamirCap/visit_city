import 'dart:async';

import 'package:flutter/material.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';
import '../../ui/screens/sign_in_screen.dart';
import '../../res/sizes.dart';

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
        height: Sizes.HEIGHT_SIZE_75,
        child: Center(
            child: Image.asset(
          AssPath.LOGO_WHITE,
          width: Sizes.WIDTH_SIZE_300,
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
    Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
  }
}
