import 'package:flutter/material.dart';
import 'package:visit_city/qr/qr.dart';
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
        body: Qr());
  }
}

/// reference for library ...WishlistScreen
/// https://pub.dev/packages/flutter_qr_reader#-readme-tab-
/// https://pub.dev/packages/permission_handler
