import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:visit_city/models/auth/signup_wrapper.dart';
import 'package:visit_city/models/fb_login/fb_login_send_model.dart';
import 'package:visit_city/models/google_login/google_login_send_model.dart';

import 'api_keys.dart';
import '../models/auth/login_wrapper.dart';
import '../models/auth/signup_send_model.dart';
import '../models/message_model.dart';
import '../models/auth/login_send_model.dart';
import '../apis/api_manager.dart';
import '../models/login_later/login_later_wrapper.dart';
import '../models/fb_login/fb_login_wrapper.dart';
import '../models/google_login/google_login_wrapper.dart';

class AuthApiManager extends ApiManager {
  void loginApis(LoginSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.loginUrl,
            headers: await ApiKeys.getAuthHeaders(),
            body: json.encode(model.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        LoginWrapper wrapper = LoginWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void signupApi(SignupSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.signupUrl,
            headers: await ApiKeys.getAuthHeaders(),
            body: json.encode(model.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        SignupWrapper wrapper = SignupWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void loginLaterApis(Function success, Function fail) async {
    await http
        .post(ApiKeys.loginLaterUrl, headers: await ApiKeys.getAuthHeaders())
        .then((response) {
      Map extractedData = json.decode(response.body);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        LoginLaterWrapper wrapper = LoginLaterWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void fbLoginApi(
      FbLoginSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.fbLoginUrl,
            headers: await ApiKeys.getAuthHeaders(),
            body: json.encode(model.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        FbLoginWrapper wrapper = FbLoginWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }

  void googleLoginApi(
      GoogleLoginSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.googleLoginUrl,
            headers: await ApiKeys.getAuthHeaders(),
            body: json.encode(model.toJson()))
        .then((response) {
      Map extractedData = json.decode(response.body);
      print(extractedData);
      if (extractedData == null) {
        fail(MessageModel.getDecodeError());
        return false;
      } else {
        GoogleLoginWrapper wrapper = GoogleLoginWrapper.fromJson(extractedData);
        if (wrapper.info) {
          success(wrapper);
          return true;
        } else {
          fail(wrapper.message);
          return false;
        }
      }
    }).catchError((onError) {
      fail(checkErrorType(onError));
    });
  }
}
