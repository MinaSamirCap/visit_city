import 'dart:async';

import 'package:flutter/material.dart';
import '../../ui/screens/sign_in_screen.dart';
import '../../utils/lang/app_localization.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';


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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height,
      width: deviceSize.width,
      color: Coolor.PRIMARYSWATCH,
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
  startTime() async {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration, navigationPage);
  }

  /// navigate with dummy screen
  Future<void> navigationPage() async {
    await Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
  }
}
