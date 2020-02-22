import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import '../../apis/api_manager.dart';
import '../../models/feedback/feedback_send_model.dart';
import '../../ui/widget/ui.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  int rateId = -1;
  TextEditingController _controller = TextEditingController();
  String _errorText;
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);
    progressDialog = getPlzWaitProgress(context, _appLocal);
    return Scaffold(
      key: _scaffoldKey,
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
          rateImgWidget(IMG_VERY_BAD_ID, AssPath.IMOJI1),
          rateImgWidget(IMG_BAD_ID, AssPath.IMOJI2),
          rateImgWidget(IMG_NOT_GOOD_NOT_BAD_ID, AssPath.IMOJI3),
          rateImgWidget(IMG_GOOD_ID, AssPath.IMOJI4),
          rateImgWidget(IMG_VERY_GOOD_ID, AssPath.IMOJI5)
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
        controller: _controller,
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
            errorText: _errorText),
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
    if (rateId == -1) {
      showSnackBar(
          createSnackBar(_appLocal.translate(LocalKeys.FEEDBACK_IMAGE_ERROR)),
          _scaffoldKey);
    } else if (_controller.text.isEmpty) {
      _errorText = _appLocal.translate(LocalKeys.LEAVE_YOUR_COMMENT);
      showSnackBar(
          createSnackBar(_appLocal.translate(LocalKeys.FEEDBACK_COMMENT_ERROR)),
          _scaffoldKey);
      setState(() {});
    } else {
      _errorText = null;
      setState(() {
        /// call api .. :)
        callFeedbackApi();
        //print("submit: ${_controller.text} rate: $rateId");
      });
    }
  }

  Future<void> callFeedbackApi() async {
    try {
      progressDialog.show();
      await Provider.of<ApiManager>(context, listen: false)
          .feedbackApi(FeedbackSendModel(rateId, _controller.text))
          .then((isSuccess) {
        progressDialog.hide();
        if (isSuccess) Navigator.pop(context);
      });
    } /*on HttpException catch (error) {
      var errorMessage = error;
      
      _showErrorDialog(errorMessage.toString());
      print(errorMessage.toString());
    } */
    catch (error) {
      print(error);
      progressDialog.hide();
      //_showErrorDialog(error.toString());
    }
  }
}
