import 'package:flutter/material.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class WishlistScreen extends StatelessWidget {
  static const ROUTE_NAME = '/wishlist';

  @override
  Widget build(BuildContext context) {
    final _appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_appLocal.translate(LocalKeys.WISHLIST)),
        ),
        body: Center(
          child: Text(
            _appLocal.translate(LocalKeys.WISHLIST),
          ),
        ));
  }
}
