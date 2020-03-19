import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';
import '../../res/assets_path.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';
import '../../models/forget_password/forget_password_send_model.dart';
import '../../apis/api_manager.dart';
import '../../models/forget_password/forget_password_wrapper.dart';
import '../../ui/base/base_state.dart';
import '../../ui/widget/ui.dart';
import '../../models/message_model.dart';
import '../../ui/screens/reset_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const ROUTE_NAME = '/forget-password';
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with BaseState {
  var appLocal;
  ForgetPasswordSendModel model = ForgetPasswordSendModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoadingNow = false;
  ProgressDialog _progressDialog;
  ApiManager _apiManager;

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, appLocal);
      _apiManager = Provider.of<ApiManager>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    appLocal = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Coolor.BG_COLOR,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Coolor.BLACK),
          title: Text(
            appLocal.translate(LocalKeys.FORGET_PASSWORD),
            style: TextStyle(
              color: Coolor.BLACK,
            ),
          ),
          backgroundColor: Coolor.WHITE,
        ),
        body: Container(
          height: deviceSize.height,
          width: deviceSize.width * 0.85,
          margin: Sizes.EDEGINSETS_25,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Sizes.SIZE_20,
                ),
                Image.asset(
                  AssPath.FORGET_PASS_LOGO,
                  scale: 2,
                ),
                SizedBox(
                  height: Sizes.SIZE_50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      appLocal.translate(LocalKeys.REGESTERED_EMAIL),
                      style: TextStyle(fontSize: Sizes.SIZE_20),
                    ),
                    SizedBox(
                      height: Sizes.SIZE_25,
                    ),
                    Text(
                      appLocal.translate(LocalKeys.SEND_VERIFICATION),
                      style: TextStyle(color: Coolor.GREY),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.SIZE_25,
                ),
                Padding(
                  padding: Sizes.EDEGINSETS_8,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: appLocal.translate(LocalKeys.EMAIL),
                        contentPadding: Sizes.EDEGINSETS_20,
                        border: OutlineInputBorder(
                          gapPadding: Sizes.SIZE_3_3,
                          borderRadius: Sizes.BOR_RAD_25,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !EmailValidator.validate(value)) {
                          return appLocal.translate(LocalKeys.ERROR_EMAIL);
                        }
                        return null;
                      },
                      onSaved: (value) {
                        model.email = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes.SIZE_25,
                ),
                RaisedButton(
                  color: Coolor.BLUE_APP,
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.SIZE_120, vertical: Sizes.SIZE_10),
                  shape: RoundedRectangleBorder(
                    borderRadius: Sizes.BOR_RAD_25,
                  ),
                  onPressed: () {
                    _submit();
                  },
                  child: Text(
                    appLocal.translate(LocalKeys.NEXT),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Coolor.WHITE,
                      fontSize: Sizes.SIZE_25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    callForgetPasswordApi();
  }

  void callForgetPasswordApi() {
    _progressDialog.show();
    _apiManager.forgetPasswordApis(model, (ForgetPasswordWrapper wrapper) {
      _progressDialog.hide();
      Navigator.of(context)
          .pushReplacementNamed(ResetPasswordScreen.ROUTE_NAME);
      setState(() {
        _isLoadingNow = false;
      });
    }, (MessageModel messageModel) {
      checkServerError(messageModel);
      _progressDialog.hide();
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  @override
  BuildContext provideContext() {
    return context;
  }
}
