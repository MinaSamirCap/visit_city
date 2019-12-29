import 'dart:async';

import 'package:flutter/material.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';

class SplashScreen extends StatelessWidget {
  static const ROUTE_NAME = '/splash';

  @override
  Widget build(BuildContext context) {
    startTime();
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height,
      width: deviceSize.width,
      color: Coolor.BLUE_APP,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 75,
            child: Image.asset(AssPath.LOGO_WHITE),
          ),
        ],
      ),
    );
  }

  /// time to switch with dummy screen
  startTime() {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration,(){});
  }

  /// navigate with dummy screen
  // void navigationPage(BuildContext context) {
  //   Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
  // }
}
