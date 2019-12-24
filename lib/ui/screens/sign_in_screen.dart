import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';

import '../../res/coolor.dart';
import '../../utils/lang/app_localization.dart';
import '../../utils/lang/app_localization_keys.dart';
import '../../res/assets_path.dart';

import '../../res/sizes.dart';
import './home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const ROUTE_NAME = '/signin-screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _form = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
      // backgroundColor: Coolor.WHITE,
      body: Container(
        margin: Sizes.EDEGINSETS_20,
        child: SingleChildScrollView(
          child: Form(
            key: _form,
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
          if (value.isEmpty) {
            return LocalKeys.ERROR_EMAIL;
          } else {
            //show something
            return '';
          }
        },
      ),
    );
  }

  Widget forgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Text(LocalKeys.FORGET_PASSWORD),
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
          if (value.isEmpty) {
            return LocalKeys.ERROR_PASSWOED;
          } else {
            //show something
            return '';
          }
        },
      ),
    );
  }

  Widget loginButton() {
    return Material(
      elevation: 5.0,
      borderRadius: Sizes.BOR_RAD_25,
      color: Coolor.PRIMARYSWATCH,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
        },
        child: Text(
          LocalKeys.LOG_IN,
          textAlign: TextAlign.center,
          style: TextStyle(color: Coolor.WHITE),
        ),
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
          child: Text(LocalKeys.SIGN_UP),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget signInLaterButton() {
    return Center(
      child: FlatButton(
        child: Text(LocalKeys.Sign_In_Later),
        onPressed: () {},
      ),
    );
  }
}
