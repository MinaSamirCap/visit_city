import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../general/validation.dart';
import '../../general/url_launchers.dart';
import '../../models/explore/open_hour_model.dart';
import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/coolor.dart';
import 'explore_cell_widget.dart';

Widget lineDivider({double height}) {
  return Container(
    color: Coolor.GREY,
    width: double.infinity,
    height: height == null ? 2 : height,
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
        padding: const EdgeInsets.all(3.0),
        child: CircularProgressIndicator(),
      ),
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Coolor.BLACK, fontSize: 16.0, fontWeight: FontWeight.w500));
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
    image: url == null ? "" : url,
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
  return RatingBarIndicator(
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
  );
}

UnderlineTabIndicator getTabIndicator() {
  return UnderlineTabIndicator(
      borderSide: BorderSide(color: Coolor.BLUE_APP, width: 3.0),
      insets: EdgeInsets.symmetric(horizontal: 60.0));
}

Widget getCenterCircularProgress() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget overviewWidget(
    AppLocalizations appLocale,
    double rate,
    List<double> location,
    String desc,
    OpenHourModel openHours,
    String price,
    String contact,
    String website) {
  return Padding(
    padding: Sizes.EDEGINSETS_15,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ratingOrangeWidget(rate),
            ExploreCellWidget(appLocale.translate(LocalKeys.GO), Icons.near_me,
                () {
              if (location.isNotEmpty && location.length == 2) {
                launchMap(location[0], location[1]);
              }
            }),
          ],
        ),
        if (isNullOrEmpty(desc))
          ...{
            Text(desc, style: TextStyle(fontSize: 20)),
            Sizes.DIVIDER_HEIGHT_20,
          }.toList(),
        rowTextWithIcon(Icons.access_time, "${openHours.from} ${openHours.to}"),
        Sizes.DIVIDER_HEIGHT_10,
        if (isNullOrEmpty(price))
          ...{
            rowTextWithIcon(Icons.monetization_on, price),
            Sizes.DIVIDER_HEIGHT_10
          }.toList(),
        if (isNullOrEmpty(contact))
          ...{
            rowTextWithIcon(Icons.contact_phone, contact, func: () {
              launchPhone(contact).then((value) {
                if (!value) {
                  showToast(appLocale.translate(LocalKeys.CAN_NOT_OPEN_DIAL));
                }
              });
            }),
            Sizes.DIVIDER_HEIGHT_10
          }.toList(),
        if (isNullOrEmpty(website))
          ...{
            rowTextWithIcon(Icons.web, website, func: () {
              launchUrlWithHttp(website);
            }),
            Sizes.DIVIDER_HEIGHT_10,
          }.toList(),
      ],
    ),
  );
}

Widget rowTextWithIcon(IconData iconData, String txt, {Function func}) {
  return Row(
    children: <Widget>[
      Icon(iconData, color: Coolor.BLUE_APP),
      Sizes.DIVIDER_WIDTH_10,
      InkWell(
        onTap: func,
        child: Text(
          txt,
          style: TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}

Widget textFormWidget(
    TextEditingController controller, String label, String errorText) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    maxLines: 3,
    minLines: 3,
    decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: label,
        contentPadding: Sizes.EDEGINSETS_20,
        border: OutlineInputBorder(
          gapPadding: 3.3,
          borderRadius: Sizes.BOR_RAD_25,
        ),
        errorText: errorText),
  );
}

Widget postReviewWidget(AppLocalizations appLocale,
    TextEditingController controller, String errorText) {
  return textFormWidget(
      controller, appLocale.translate(LocalKeys.LEAVE_YOUR_REVIEW), errorText);
}

Widget postReviewBtnWidget(AppLocalizations appLocale, Function clicked) {
  return RaisedButton(
    onPressed: clicked,
    shape: RoundedRectangleBorder(
      borderRadius: Sizes.BOR_RAD_25,
    ),
    color: Coolor.BLUE_APP,
    textColor: Coolor.WHITE,
    child: Text(appLocale.translate(LocalKeys.POST)),
  );
}

Widget postRatingOrangeWidget(Function onRateUpdated, double initRate) {
  return RatingBar(
    initialRating: initRate,
    itemCount: 5,
    itemSize: 30,
    itemPadding: EdgeInsets.all(0),
    itemBuilder: (ctx, index) {
      return Icon(
        Icons.star,
        color: Coolor.ORANGE,
      );
    },
    onRatingUpdate: onRateUpdated,
  );
}

Widget postReviewRowWidget(AppLocalizations appLocale, Function onRateUpdated,
    double initRate, Function clicked) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      postRatingOrangeWidget(onRateUpdated, initRate),
      postReviewBtnWidget(appLocale, clicked)
    ],
  );
}

Widget getNotPicWidget(AppLocalizations appLocale) {
  return Text(
    appLocale.translate(LocalKeys.NO_PIC),
    style: TextStyle(color: Coolor.WHITE),
  );
}

Widget userReview(
    String picUrl, String userName, double rate, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 33,
            backgroundColor: Coolor.GREY,
            backgroundImage: NetworkImage(picUrl),
          ),
          Sizes.DIVIDER_WIDTH_10,
          Text(
            userName,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
      ratingOrangeWidget(rate),
      Text(description)
    ],
  );
}
