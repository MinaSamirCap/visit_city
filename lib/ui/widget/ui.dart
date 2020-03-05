import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../res/assets_path.dart';
import '../../res/sizes.dart';
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

Widget pagingLoadingWidget(bool isLoading) {
  return AnimatedContainer(
    curve: Curves.fastOutSlowIn,
    padding: Sizes.EDEGINSETS_10,
    height: isLoading ? 55.0 : 0,
    color: isLoading ? Coolor.BLUE_APP : Colors.transparent,
    child: Center(
      child: new CircularProgressIndicator(),
    ),
    duration: Duration(milliseconds: 300),
  );
}

Widget exploreImgWidget(double width, String url) {
// I am sure it is working tested on real device ...
  return FadeInImage.assetNetwork(
    placeholder: AssPath.APP_LOGO,
    image: url != null ? "" : url,
    height: double.infinity,
    width: width,
    fit: BoxFit.cover,
    fadeInDuration: new Duration(milliseconds: 100),
  );
}

Widget ratingWidget(double rate) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
    child: RatingBarIndicator(
      rating: rate,
      itemCount: 5,
      itemSize: 20,
      itemPadding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) {
        return Icon(
          Icons.star,
          color: Coolor.BLUE_APP,
        );
      },
    ),
  );
}

Widget ratingOrangeWidget(double rate) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
    child: RatingBarIndicator(
      rating: rate,
      itemCount: 5,
      itemSize: 20,
      itemPadding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) {
        return Icon(
          Icons.star,
          color: Coolor.ORANGE,
        );
      },
    ),
  );
}

UnderlineTabIndicator getTabIndicator() {
  return UnderlineTabIndicator(
      borderSide: BorderSide(color: Coolor.BLUE_APP, width: 3.0),
      insets: EdgeInsets.symmetric(horizontal: 60.0));
}
