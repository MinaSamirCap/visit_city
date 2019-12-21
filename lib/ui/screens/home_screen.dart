import 'package:flutter/material.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE_NAME = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(appLocal.translate(LocalKeys.APP_NAME)),
        ),
        body: Center(
          child: Text(appLocal.translate(LocalKeys.APP_NAME)),
        ));
  }
}
