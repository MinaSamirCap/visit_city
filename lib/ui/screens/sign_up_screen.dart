import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../../res/sizes.dart';
import '../../res/coolor.dart';
import '../../res/assets_path.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../apis/auth.dart';
import '../../ui/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const ROUTE_NAME = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': "",
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  var appLocal;

  final _passwordController = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("${appLocal.translate(LocalKeys.DIALOG_ERROR)}"),
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
      print('Invalid');
      print(_authData['name']);
      print(_authData['email']);
      print(_authData['password']);
      return;
    }
    _formKey.currentState.save();

    try {
      // Sign user up
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['name'],
        _authData['email'],
        _authData['password'],
      );
    } catch (error) {
      _showErrorDialog(error.toString());
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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

  Widget nameTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "${appLocal.translate(LocalKeys.NAME)}",
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "${appLocal.translate(LocalKeys.ERROR_NAME)}";
          }
        },
        onSaved: (value) {
          _authData['name'] = value;
        },
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "${appLocal.translate(LocalKeys.EMAIL)}",
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty || !EmailValidator.validate(value)) {
            return "${appLocal.translate(LocalKeys.ERROR_EMAIL)}";
          }
        },
        onSaved: (value) {
          _authData['email'] = value;
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
          labelText: "${appLocal.translate(LocalKeys.PASSWORD)}",
          contentPadding: Sizes.EDEGINSETS_20,
          border: OutlineInputBorder(
            gapPadding: 3.3,
            borderRadius: Sizes.BOR_RAD_25,
          ),
        ),
        validator: (value) {
          if (value.isEmpty || value.length < 8) {
            return "${appLocal.translate(LocalKeys.ERROR_PASSWORD)}";
          }
        },
        onSaved: (value) {
          _authData['password'] = value;
        },
      ),
    );
  }

  Widget passwordConfirmTextField() {
    return Padding(
      padding: Sizes.EDEGINSETS_8,
      child: TextFormField(
          decoration: InputDecoration(
            labelText: "${appLocal.translate(LocalKeys.CONFIRM_PASSWORD)}",
            contentPadding: Sizes.EDEGINSETS_20,
            border: OutlineInputBorder(
              gapPadding: 3.3,
              borderRadius: Sizes.BOR_RAD_25,
            ),
          ),
          obscureText: true,
          validator: (value) {
            if (value != _passwordController.text) {
              return "${appLocal.translate(LocalKeys.PASS_DONT_MATCH)}";
            }
          }),
    );
  }

  Widget signupButton() {
    return RaisedButton(
      color: Coolor.PRIMARYSWATCH,
      // minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70.0),
      shape: RoundedRectangleBorder(
        borderRadius: Sizes.BOR_RAD_25,
      ),
      onPressed: () {
        _submit();
        // Navigator.of(context).pushReplacementNamed(SignInScreen.ROUTE_NAME);
      },
      child: Text(
        "${appLocal.translate(LocalKeys.SIGN_UP)}",
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
        "${appLocal.translate(LocalKeys.HAVE_ACCOUNT)}",
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
}
