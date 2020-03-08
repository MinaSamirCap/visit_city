import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visit_city/ui/screens/sight_details_screen.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';

class QrCodeScreen extends StatefulWidget {
  static const ROUTE_NAME = '/qr-code';

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();
  bool isPermissionGranded = false;
  bool isShowPermissionLayout = false;
  AppLocalizations _appLocal;
  double width = 0.0;

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
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(_appLocal.translate(LocalKeys.QR_CODE)),
        ),
        body: getBody());
  }

  Widget getBody() {
    if (isPermissionGranded) {
      return scanView();
    } else {
      if (isShowPermissionLayout) {
        return requestPermissionLayout();
      } else {
        return getLoadingView();
      }
    }
  }

  Widget scanView() {
    return Stack(
      children: <Widget>[
        QrcodeReaderView(key: _key, onScan: onScan, helpWidget: Text("")),
        Positioned(
            bottom: 0,
            child: Container(
              height: 100,
              width: width,
              color: Coolor.BLUE_APP,
              child: Center(
                  child: Text(
                _appLocal.translate(LocalKeys.PLZ_ALIGN_QR),
                style: TextStyle(fontSize: 20, color: Coolor.WHITE),
                textAlign: TextAlign.center,
              )),
            ))
      ],
    );
  }

  Future onScan(String data) async {
    await Navigator.of(context).pushNamed(SightDetailsScreen.ROUTE_NAME,
        arguments: {SightDetailsScreen.MODEL_ID_KEY: int.parse(data)});
    _key.currentState.startScan();
  }

  Widget getLoadingView() {
    return Container(
      color: Coolor.BLACK,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
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
      setState(() {
        isPermissionGranded = true;
      });
    } else {
      setState(() {
        isPermissionGranded = false;
        isShowPermissionLayout = true;
      });
    }
  }
}

/// reference for library ...WishlistScreen
/// https://pub.dev/packages/flutter_qr_reader#-readme-tab-
/// https://pub.dev/packages/permission_handler
