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

class SignInScreen extends StatefulWidget {
  static const ROUTE_NAME = '/signin-screen';

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

    return Scaffold(
      // backgroundColor: Coolor.WHITE,
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        margin: Sizes.EDEGINSETS_20,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155,
                ),
                logoImage(),
                SizedBox(
                  height: 45,
                ),
                emailTextField(),
                passwordTextField(),
                forgetPasswordButton(),
                SizedBox(
                  height: 25.0,
                ),
                loginButton(),
                SizedBox(
                  height: 35.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    fbLogin(),
                    googleLogin(),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${appLocal.translate(LocalKeys.HAVE_ACCOUNT)}"),
                        registerButton(),
                      ],
                    ),
                    signInLaterButton(),
                  ],
                ),
              ],
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
          labelText: LocalKeys.EMAIL,
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

  Widget forgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text("${appLocal.translate(LocalKeys.FORGET_PASSWORD)}"),
          onPressed: () {},
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
          labelText: LocalKeys.PASSWORD,
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

  Widget loginButton() {
    return  RaisedButton(
      color: Coolor.PRIMARYSWATCH,
        // minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 17.0,horizontal: 70.0),
        shape: RoundedRectangleBorder(
          borderRadius: Sizes.BOR_RAD_25,
        ),
        onPressed: () {
          _submit();
          // Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
        },
        child: Text(
          "${appLocal.translate(LocalKeys.LOG_IN)}",
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
          child: Text("${appLocal.translate(LocalKeys.SIGN_UP)}"),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget signInLaterButton() {
    return Center(
      child: FlatButton(
        child: Text("${appLocal.translate(LocalKeys.SIGN_IN_LATER)}"),
        onPressed: () {},
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("${appLocal.translate(LocalKeys.DIALOG_ERROR)}"),
        
        content: Text(message),
        actions: <Widget>[
          FlatButton(child: Text('OK'),onPressed: () {
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
    setState(() {
      print(_authData['email']);
      print(_authData['password']);
      _isLoading = true;
    });
    try {
        await Provider.of<Auth>(context, listen: false).signIn(
          _authData['email'],
          _authData['password'],
        );
    } catch (error) {
      _showErrorDialog(error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }
}
