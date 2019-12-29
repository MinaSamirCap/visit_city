import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../utils/lang/app_localization_keys.dart';
import '../../utils/lang/app_localization.dart';
import '../../apis/auth.dart';
import '../../res/assets_path.dart';
import '../../res/coolor.dart';
import '../../res/sizes.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const ROUTE_NAME = '/forget-password';
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var appLocal;
  Map<String, String> _authData = {'email': ""};
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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Coolor.BLACK),
          // automaticallyImplyLeading: true,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () => Navigator.pop(context),
          // ),
          title: Text(
            "Forget Password",
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
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Image.asset(AssPath.LOGO_BLUE),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      appLocal.translate(LocalKeys.REGESTERED_EMAIL),
                      // textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${appLocal.translate(LocalKeys.SEND_VERIFICATION)}",
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
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
                        return appLocal.translate(LocalKeys.ERROR_EMAIL);
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  color: Coolor.PRIMARYSWATCH,
                  // minWidth: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 18.0, horizontal: 150.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: Sizes.BOR_RAD_25,
                  ),
                  onPressed: () {
                    // _submit();
                    // Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE_NAME);
                  },
                  child: Text(
                    appLocal.translate(LocalKeys.NEXT),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Coolor.WHITE,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
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
}
