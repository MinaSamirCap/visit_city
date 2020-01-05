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
      appBar: AppBar(
        backgroundColor: Coolor.FEEDBACK_OFF_WHITE,
        iconTheme: IconThemeData(
          color: Coolor.BLACK,
        ),
        title: Text(
          _appLocal.translate(LocalKeys.FEEDBACK),
          style: TextStyle(color: Coolor.BLACK),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Coolor.FEEDBACK_OFF_WHITE,
          child: Column(
            children: <Widget>[
              Sizes.DIVIDER_HEIGHT_100,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_appLocal.translate(LocalKeys.SEND_YOURS)),
                  Text("${_appLocal.translate(LocalKeys.FEEDBACK)} !")
                ],
              ),
              Padding(
                padding: Sizes.EDEGINSETS_25,
                child: Text(_appLocal.translate(LocalKeys.YOUR_REVIEW_WILL_BE)),
              ),
              Text(_appLocal.translate(LocalKeys.LEAVE_YOUR_COMMENT)),
              Text(_appLocal.translate(LocalKeys.SEND))
            ],
          ),
        ),
      ),
    );
  }
}
