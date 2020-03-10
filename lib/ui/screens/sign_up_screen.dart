import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:visit_city/apis/auth_api_manager.dart';
import 'package:visit_city/models/auth/signup_send_model.dart';
import 'package:visit_city/models/auth/signup_wrapper.dart';
import 'package:visit_city/models/message_model.dart';
import 'package:visit_city/ui/widget/ui.dart';

import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../ui/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const ROUTE_NAME = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  AppLocalizations _appLocal;
  bool _isLoadingNow = false;
  ProgressDialog _progressDialog;
  AuthApiManager _apiAuthManager;
  SignupSendModel model = SignupSendModel();

  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _progressDialog = getPlzWaitProgress(context, _appLocal);
      _apiAuthManager = Provider.of<AuthApiManager>(context, listen: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Coolor.BG_COLOR,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: Sizes.EDEGINSETS_20,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 85,
                  ),
                  logoImage(),
                  SizedBox(
                    height: 45,
                  ),
                  nameTextField(),
                  emailTextField(),
                  passwordTextField(),
                  passwordConfirmTextField(),
                  countryTextField(),
                  mobileTextField(),
                  SizedBox(
                    height: 30,
                  ),
                  signupButton(),
                  SizedBox(
                    height: 30,
                  ),
                  haveAccount(),
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

  Widget mobileTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: _appLocal.translate(LocalKeys.MOBILE),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        onSaved: (value) {
          model.phone = value;
        },
      ),
    );
  }

  Widget countryTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: _appLocal.translate(LocalKeys.COUNTRY),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        onSaved: (value) {
          model.country = value;
        },
      ),
    );
  }

  Widget nameTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: _appLocal.translate(LocalKeys.NAME),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return _appLocal.translate(LocalKeys.ERROR_NAME);
          }
          return null;
        },
        onSaved: (value) {
          model.name = value;
        },
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
        validator: (value) {
          if (value.isEmpty || !EmailValidator.validate(value)) {
            return _appLocal.translate(LocalKeys.ERROR_EMAIL);
          }
          return null;
        },
        onSaved: (value) {
          model.email = value;
        },
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        obscureText: true,
        controller: _passwordController,
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

  Widget passwordConfirmTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
          decoration: InputDecoration(
            labelText: _appLocal.translate(LocalKeys.CONFIRM_PASSWORD),
            contentPadding: Sizes.EDEGINSETS_20,
            border: OutlineInputBorder(
              gapPadding: 3.3,
              borderRadius: Sizes.BOR_RAD_25,
            ),
          ),
          obscureText: true,
          validator: (value) {
            if (value != _passwordController.text) {
              return _appLocal.translate(LocalKeys.PASS_DONT_MATCH);
            }
            return null;
          }),
    );
  }

  Widget signupButton() {
    return RaisedButton(
      color: Coolor.PRIMARYSWATCH,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70.0),
      shape: RoundedRectangleBorder(
        borderRadius: Sizes.BOR_RAD_25,
      ),
      onPressed: () {
        _submit();
      },
      child: Text(
        _appLocal.translate(LocalKeys.SIGN_UP),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Coolor.WHITE,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget haveAccount() {
    return FlatButton(
      child: Text(
        _appLocal.translate(LocalKeys.HAVE_ACCOUNT),
        style: TextStyle(
          color: Coolor.GREY,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          fontFamily: 'Arial',
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
      },
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    callSignupApi();
  }

  void callSignupApi() {
    _progressDialog.show();
    _apiAuthManager.signupApi(model, (SignupWrapper wrapper) {
      _progressDialog.hide();
      Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
    }, (MessageModel messageModel) {
      _progressDialog.hide();
      showSnackBar(createSnackBar(messageModel.message), _scaffoldKey);
    });
  }
}
