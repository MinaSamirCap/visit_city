import 'package:flutter/material.dart';
import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';

const int IMG_VERY_BAD_ID = 0;
const int IMG_BAD_ID = 1;
const int IMG_NOT_GOOD_NOT_BAD_ID = 2;
const int IMG_GOOD_ID = 3;
const int IMG_VERY_GOOD_ID = 4;

class FeedbackScreen extends StatefulWidget {
  static const ROUTE_NAME = '/feedback-screen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  AppLocalizations _appLocal;
  int rateId = -1;
  String comment = "";

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: getAppBarWidget(),
      body: SingleChildScrollView(
        child:
            Container(color: Coolor.FEEDBACK_OFF_WHITE, child: getColumnBody()),
      ),
    );
  }

  AppBar getAppBarWidget() {
    return AppBar(
        backgroundColor: Coolor.FEEDBACK_OFF_WHITE,
        iconTheme: IconThemeData(
          color: Coolor.BLACK,
        ),
        title: Text(
          _appLocal.translate(LocalKeys.FEEDBACK),
          style: TextStyle(color: Coolor.BLACK),
        ));
  }

  Widget getColumnBody() {
    return Column(
      children: <Widget>[
        Sizes.DIVIDER_HEIGHT_100,
        colorTitleWidget(),
        Padding(padding: Sizes.EDEGINSETS_25, child: getDescriptionWidget()),
        ratingImgsWidget(),
        leaveYourCommentWidget(),
        Sizes.DIVIDER_HEIGHT_10,
        sendWidget(),
        Sizes.DIVIDER_HEIGHT_10,
      ],
    );
  }

  Widget colorTitleWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _appLocal.translate(LocalKeys.SEND_YOURS),
          style: getColorStyle(Coolor.BLACK),
        ),
        Sizes.DIVIDER_WIDTH_5,
        Text(
          "${_appLocal.translate(LocalKeys.FEEDBACK)}!",
          style: getColorStyle(Coolor.PRIMARYSWATCH),
        )
      ],
    );
  }

  TextStyle getColorStyle(Color color) {
    return TextStyle(
        fontSize: Sizes.SIZE_25, fontWeight: FontWeight.bold, color: color);
  }

  Widget getDescriptionWidget() {
    return Text(_appLocal.translate(LocalKeys.YOUR_REVIEW_WILL_BE),
        style: TextStyle(fontSize: Sizes.SIZE_20));
  }

  Widget ratingImgsWidget() {
    return Padding(
      padding: Sizes.EDEGINSETS_10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          rateImgWidget(IMG_VERY_BAD_ID, AssPath.LOGO_GOOGLE),
          rateImgWidget(IMG_BAD_ID, AssPath.LOGO_GOOGLE),
          rateImgWidget(IMG_NOT_GOOD_NOT_BAD_ID, AssPath.LOGO_GOOGLE),
          rateImgWidget(IMG_GOOD_ID, AssPath.LOGO_GOOGLE),
          rateImgWidget(IMG_VERY_GOOD_ID, AssPath.LOGO_GOOGLE)
        ],
      ),
    );
  }

  Widget rateImgWidget(int imgId, String imgPath) {
    return InkWell(
      onTap: () {
        imgSelectd(imgId);
      },
      child: Image.asset(
        imgPath,
        width: Sizes.SIZE_60,
        height: Sizes.SIZE_60,
        color: rateId == imgId ? Coolor.BLUE_APP : Coolor.GREY,
      ),
    );
  }

  void imgSelectd(int imgId) {
    rateId = imgId;
    setState(() {});
    print("Image Selected $rateId");
  }

  Widget leaveYourCommentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 5,
        minLines: 5,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: _appLocal.translate(LocalKeys.LEAVE_YOUR_COMMENT),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        validator: (value) {
          if (value.isEmpty || value.length < 8) {
            return _appLocal.translate(LocalKeys.LEAVE_YOUR_COMMENT);
          } else
            return null;
        },
        onSaved: (value) {
          comment = value;
          print("Comment $comment");
        },
      ),
    );
  }

  Widget sendWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        RaisedButton(
          onPressed: _submit,
          shape: RoundedRectangleBorder(
            borderRadius: Sizes.BOR_RAD_25,
          ),
          color: Coolor.BLUE_APP,
          textColor: Coolor.WHITE,
          child: Text(_appLocal.translate(LocalKeys.SEND)),
        ),
      ]),
    );
  }

  void _submit() {
    print("submit");
  }
}
