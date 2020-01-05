import 'package:flutter/material.dart';
import 'package:visit_city/res/sizes.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';

class FeedbackScreen extends StatefulWidget {
  static const ROUTE_NAME = '/feedback-screen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  AppLocalizations _appLocal;

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child:
            Container(color: Coolor.FEEDBACK_OFF_WHITE, child: getColumnBody()),
      ),
    );
  }

  AppBar getAppBar() {
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
        colorTitle(),
        Padding(padding: Sizes.EDEGINSETS_25, child: getDescription()),
        Text(
          _appLocal.translate(LocalKeys.LEAVE_YOUR_COMMENT),
        ),
        Text(_appLocal.translate(LocalKeys.SEND))
      ],
    );
  }

  Widget colorTitle() {
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

  Widget getDescription() {
    return Text(_appLocal.translate(LocalKeys.YOUR_REVIEW_WILL_BE),
        style: TextStyle(fontSize: Sizes.SIZE_20));
  }
}
