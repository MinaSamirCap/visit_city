import 'package:flutter/material.dart';
import 'package:visit_city/models/message_model.dart';
import 'package:visit_city/prefs/pref_manager.dart';
import 'package:visit_city/ui/screens/sign_in_screen.dart';
import 'package:visit_city/ui/widget/ui.dart';

abstract class BaseState{

  BuildContext provideContext();

  void checkServerError(MessageModel model) {
    switch (model.messageId) {
      case 401:
        {
          logoutNow(model.message);
        }
        break;
    }
  }

  void logoutNow(String message) async {
    showToast(message);
    await PrefManager.clearAllData();
    Navigator.of(provideContext()).pushNamedAndRemoveUntil(
        SignInScreen.ROUTE_NAME, (Route<dynamic> route) => false);
  }
}
