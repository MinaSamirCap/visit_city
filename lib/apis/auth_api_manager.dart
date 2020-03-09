import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:visit_city/models/auth/login_wrapper.dart';
import 'package:visit_city/models/message_model.dart';

import '../models/auth/login_send_model.dart';
import 'api_keys.dart';
import '../apis/api_manager.dart';

class AuthApiManager extends ApiManager {
  void loginApis(LoginSendModel model, Function success, Function fail) async {
    await http
        .post(ApiKeys.loginUrl,
            headers: ApiKeys.getAuthHeaders(),
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

  // Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) {
  //     return false;
  //   }
  //   final extractedUserData =
  //       json.decode(prefs.getString('userData')) as Map<String, dynamic>;
  //   _info = extractedUserData['info'];
  //   _token = extractedUserData['token'];
  //   _userId = extractedUserData['userId'];
  //   if (info == false) {
  //     return false;
  //   }

  //   _autoLogout();
  //   return true;
  // }

  // Future<void> signIn(String email, String password) async {
  //   final url = 'https://visit-fayoum.herokuapp.com/api/v1/login';
  //   try {
  //     print('okay');
  //     final response = await http.post(
  //       url,
  //       headers: header,
  //       body: json.encode(
  //         {
  //           'username': email,
  //           'password': password,
  //         },
  //       ),
  //     );
  //     final responseData = json.decode(response.body);
  //     if (responseData['errors'] != null) {
  //       throw HttpException(responseData['errors']['message']);
  //     }
  //     _token = responseData['data']['token'];
  //     _userId = responseData['data']['user']['id'];
  //     _info = responseData['info'];

  //     final prefs = await SharedPreferences.getInstance();
  //     final userData = json.encode({
  //       'token': _token,
  //       'userId': _userId,
  //       'info': _info,
  //     });
  //     prefs.setString('userData', userData);
  //     print(_token);
  //     print(isAuth.toString());
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> signUp(String name, String email, String password, String mobile,
  //     String country) async {
  //   final url = 'https://visit-fayoum.herokuapp.com/api/v1/signup';
  //   try {
  //     print('okay');
  //     final response = await http.post(
  //       url,
  //       headers: header,
  //       body: json.encode(
  //         {
  //           'email': email,
  //           'password': password,
  //           'name': name,
  //           'phone': mobile,
  //           'country': country,
  //         },
  //       ),
  //     );
  //     final responseData = json.decode(response.body);
  //     if (responseData['errors'] != null) {
  //       throw HttpException(responseData['message'][0]['message']);
  //     }
  //     _token = responseData['token'];
  //     _autoLogout();
  //     notifyListeners();
  //     print(json.decode(response.body));
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> logout() async {
  //   _token = null;
  //   _userId = null;
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //     _authTimer = null;
  //   }
  //   notifyListeners();
  //   final prefs = await SharedPreferences.getInstance();
  //   //if store multiple data in shared preferences then call this method
  //   // prefs.remove();
  //   //only user data
  //   prefs.clear();
  // }

  // void _autoLogout() {
  //   if (info == false) {
  //     logout();
  //   }
  // }
}
