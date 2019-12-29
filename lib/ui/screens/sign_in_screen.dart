import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/assets_path.dart';
import '../../utils/lang/http_exception.dart';
import '../../res/sizes.dart';
import '../../apis/auth.dart';
import '../../ui/screens/home_screen.dart';
import '../../ui/screens/sign_up_screen.dart';
import '../../ui/screens/forget_password_screen.dart';

class SignInScreen extends StatefulWidget {
  static const ROUTE_NAME = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  var appLocal;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

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
        backgroundColor: Coolor.BG_COLOR,
        // backgroundColor: Coolor.WHITE,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: Sizes.EDEGINSETS_20,
          child: SingleChildScrollView(
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
                        "${appLocal.translate(LocalKeys.DONT_HAVE_ACCOUNT)}",
                      ),
                      registerButton(),
                    ],
                  ),
                  signInLaterButton(),
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
          labelText: appLocal.translate(LocalKeys.EMAIL),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty || !EmailValidator.validate(value)) {
            return appLocal.translate(LocalKeys.ERROR_EMAIL);
          }
          // return "";
        },
        onSaved: (value) {
          _authData['email'] = value;
        },
      ),
    );
  }

  Widget forgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(appLocal.translate(LocalKeys.FORGET_PASSWORD)),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(ForgetPasswordScreen.ROUTE_NAME);
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
          labelText: appLocal.translate(LocalKeys.PASSWORD),
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        validator: (value) {
          if (value.isEmpty || value.length < 8) {
            return appLocal.translate(LocalKeys.ERROR_PASSWORD);
          }
        },
        onSaved: (value) {
          _authData['password'] = value;
        },
      ),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      color: Coolor.PRIMARYSWATCH,
      // minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 70.0),
      shape: RoundedRectangleBorder(
        borderRadius: Sizes.BOR_RAD_25,
      ),
      onPressed: () {
        _submit();
        // Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
      },
      child: Text(
        appLocal.translate(LocalKeys.LOG_IN),
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
        fit: BoxFit.cover,
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
          child: Text(appLocal.translate(LocalKeys.REGISTER)),
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
        child: Text(appLocal.translate(LocalKeys.SIGN_IN_LATER)),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
        },
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(appLocal.translate(LocalKeys.DIALOG_ERROR)),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Auth>(context, listen: false).signIn(
        _authData['email'],
        _authData['password'],
      );
    }on HttpException catch (error) {
      var errorMessage = error;
      
      _showErrorDialog(errorMessage.toString());
      print(errorMessage.toString());
    } 
    catch (error) {
      _showErrorDialog(error.toString());
    }
  }
}
