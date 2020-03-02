import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../res/coolor.dart';
import '../../qr/qr.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class QrCodeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/qr-code';

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  bool isPermissionGranded = false;
  AppLocalizations _appLocal;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      checkPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_appLocal.translate(LocalKeys.QR_CODE)),
        ),
        body: isPermissionGranded ? Qr() : requestPermissionLayout());
  }

  Widget requestPermissionLayout() {
    return Padding(
      padding: Sizes.EDEGINSETS_20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _appLocal.translate(LocalKeys.WE_NEED_CAMERA_PERMISSION),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
          RaisedButton(
            color: Coolor.PRIMARYSWATCH,
            textColor: Coolor.WHITE,
            child: Text(
              _appLocal.translate(LocalKeys.ALLOW_PERMISSION),
            ),
            onPressed: checkPermission,
          )
        ],
      ),
    );
  }

  void checkPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    print(permissions);
    if (permissions[PermissionGroup.camera] == PermissionStatus.granted) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Text("ok"),
          );
        },
      );
      setState(() {
        isPermissionGranded = true;
      });
    }
  }
}

/// reference for library ...WishlistScreen
/// https://pub.dev/packages/flutter_qr_reader#-readme-tab-
/// https://pub.dev/packages/permission_handler
