import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth/login_send_model.dart';
import '../../models/auth/login_wrapper.dart';
import '../../models/message_model.dart';
import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/assets_path.dart';
import '../../res/sizes.dart';
import '../../ui/screens/home_screen.dart';
import '../../ui/screens/sign_up_screen.dart';
import '../../ui/screens/forget_password_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../apis/auth_api_manager.dart';
import '../../ui/widget/ui.dart';

class SignInScreen extends StatefulWidget {
  static const ROUTE_NAME = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppLocalizations _appLocal;
  bool _isLoadingNow = false;
  ProgressDialog _progressDialog;
  AuthApiManager _apiAuthManager;
  LoginSendModel model = LoginSendModel();

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiAuthManager = Provider.of<AuthApiManager>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appLocal = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: _isLoadingNow
          ? Scaffold(
              body: Center(
              child: CircularProgressIndicator(),
            ))
          : Scaffold(
              key: _scaffoldKey,
              backgroundColor: Coolor.BG_COLOR,
              body: Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  padding: Sizes.EDEGINSETS_20,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 85,
                        ),
                        logoImage(),
                        SizedBox(
                          height: 50,
                        ),
                        emailTextField(),
                        passwordTextField(),
                        forgetPasswordButton(),
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButton(),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            fbLogin(),
                            googleLogin(),
                          ],
                        ),
                        SizedBox(
                          height: 75,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _appLocal.translate(LocalKeys.DONT_HAVE_ACCOUNT),
                            ),
                            registerButton(),
                          ],
                        ),
                        signInLaterButton(),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO1,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO2,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO3,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO4,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO5,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO6,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  AssPath.SPONS_LOGO7,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget logoImage() {
    return Container(
      margin: Sizes.EDEGINSETS_30,
      width: double.infinity,
      // height: 150,
      child: Center(
        child: Image.asset(AssPath.LOGO_BLUE),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: _appLocal.translate(LocalKeys.EMAIL),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || !EmailValidator.validate(value)) {
            return _appLocal.translate(LocalKeys.ERROR_EMAIL);
          }
          return null;
        },
        onSaved: (value) {
          model.username = value;
        },
      ),
    );
  }

  Widget forgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(_appLocal.translate(LocalKeys.FORGET_PASSWORD)),
          onPressed: () {
            Navigator.of(context).pushNamed(ForgetPasswordScreen.ROUTE_NAME);
          },
        ),
      ],
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: _appLocal.translate(LocalKeys.PASSWORD),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        validator: (value) {
          if (value.isEmpty || value.length < 8) {
            return _appLocal.translate(LocalKeys.ERROR_PASSWORD);
          }
          return null;
        },
        onSaved: (value) {
          model.password = value;
        },
      ),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      color: Coolor.PRIMARYSWATCH,
      padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 70.0),
      shape: RoundedRectangleBorder(
        borderRadius: Sizes.BOR_RAD_25,
      ),
      onPressed: () {
        _submit();
      },
      child: Text(
        _appLocal.translate(LocalKeys.LOG_IN),
        textAlign: TextAlign.center,
        style: TextStyle(color: Coolor.WHITE),
      ),
    );
  }

  Widget fbLogin() {
    return FloatingActionButton(
      elevation: 5,
      heroTag: null,
      onPressed: () {},
      backgroundColor: Coolor.WHITE,
      child: Image.asset(
        AssPath.LOGO_FB,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget googleLogin() {
    return FloatingActionButton(
      elevation: 5,
      heroTag: null,
      onPressed: () {},
      backgroundColor: Coolor.WHITE,
      child: Image.asset(
        AssPath.LOGO_GOOGLE,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget registerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(_appLocal.translate(LocalKeys.REGISTER)),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(SignUpScreen.ROUTE_NAME);
          },
        ),
      ],
    );
  }

  Widget signInLaterButton() {
    return Center(
      child: FlatButton(
        child: Text(_appLocal.translate(LocalKeys.SIGN_IN_LATER)),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
        },
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    callloginApi();
    
  }

  void callloginApi() {
    _progressDialog.show();
    _apiAuthManager.loginApis(model, (LoginWrapper wrapper) {
      _progressDialog.hide();
      saveUsertoken(wrapper.data.token);
      setState(() {
        _isLoadingNow = false;
      });
    }, (MessageModel messageModel) {
      _progressDialog.hide();
      setState(() {
        showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
        _isLoadingNow = false;
      });
    });
  }

  void saveUsertoken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setBool('isLogedIn', true);
    Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
  }
}
