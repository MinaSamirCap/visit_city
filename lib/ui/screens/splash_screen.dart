import 'dart:async';

import 'package:flutter/material.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
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
    final appLocal = AppLocalizations.of(context);
    return Container(
      child: Center(
        child: Text(appLocal.translate(LocalKeys.WELCOME_MESSAGE)),
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
    Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
  }
}
