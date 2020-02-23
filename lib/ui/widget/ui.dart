import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/coolor.dart';

Widget lineDivider() {
  return Container(
    color: Coolor.GREY,
    width: double.infinity,
    height: 2,
  );
}

Widget lineDividerWidth(double width) {
  return Container(
    color: Coolor.GREY,
    width: width,
    height: 1,
  );
}

SnackBar createSnackBar(String message) {
  return SnackBar(content: Text(message));
}

void showSnackBar(SnackBar snackBar, GlobalKey<ScaffoldState> key) {
  key.currentState.showSnackBar(snackBar);
}

void showToast(String message) {
  /// reference 
  /// https://pub.dev/packages/fluttertoast
  /// 
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Coolor.BLACK,
      textColor: Coolor.WHITE,
      fontSize: 16.0);
}

ProgressDialog getProgress(BuildContext context, String message) {
  /// reference
  /// https://medium.com/@fayaz07/progressdialog-in-flutter-817d36bd6eb1
  ///
  var pr = new ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

  pr.style(
      message: message,
      progressWidget: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircularProgressIndicator(
          strokeWidth: 6,
        ),
      ),
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Coolor.BLACK, fontSize: 18.0, fontWeight: FontWeight.w600));
  return pr;
}

ProgressDialog getPlzWaitProgress(
    BuildContext context, AppLocalizations appLocal) {
  return getProgress(context, appLocal.translate(LocalKeys.PLZ_WAIT));
}
