import 'package:flutter/material.dart';
import 'package:visit_city/ui/screens/wishlist_screen.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class QrCodeScreen extends StatelessWidget {
  static const ROUTE_NAME = '/qr-code';

  @override
  Widget build(BuildContext context) {
    final _appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_appLocal.translate(LocalKeys.QR_CODE)),
        ),
        body: Center(
          child: Text(
            _appLocal.translate(LocalKeys.QR_CODE),
          ),
        ));
  }
}

/// reference for library ...WishlistScreen
/// https://pub.dev/packages/qr_flutter#-readme-tab-
