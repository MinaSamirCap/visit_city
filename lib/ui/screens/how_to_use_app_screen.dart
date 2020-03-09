import 'package:flutter/material.dart';

import '../../res/sizes.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class HowToUseAppScreen extends StatelessWidget {
  static const ROUTE_NAME = '/hot-to-use-app';
  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocal.translate(LocalKeys.HOW_TO_USE_APP)),
      ),
      body: SingleChildScrollView(
                      child: Container(
                width: double.infinity,
                margin: Sizes.EDEGINSETS_15,
                child: Text(
                  'How to use the application',
                  style: TextStyle(fontSize:20),
                ),
              ),
          ),
    );
  }
}