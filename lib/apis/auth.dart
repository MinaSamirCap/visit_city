import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/lang/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  int _userId;
  bool _info;
  Timer _authTimer;
  final header = {'Content-Type': 'application/json'};
  final baseUrl = 'https://visit-fayoum.herokuapp.com/api/v1/';

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  int get userId {
    return _userId;
  }

  bool get info {
    return _info;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    _info = extractedUserData['info'];
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    if (info == false) {
      return false;
    }
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> signIn(String email, String password) async {
    final url = 'https://visit-fayoum.herokuapp.com/api/v1/login';
    try {
      print('okay');
      final response = await http.post(
        url,
        headers: header,
        body: json.encode(
          {
            'username': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['errors'] != null) {
        throw HttpException(responseData['errors']['message']);
      }
      _token = responseData['data']['token'];
      _userId = responseData['data']['user']['id'];
      _info = responseData['info'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'info': _info,
      });
      prefs.setString('userData', userData);
      print(_token);
      print(isAuth.toString());
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    final url = 'https://visit-fayoum.herokuapp.com/api/v1/signup';
    try {
      print('okay');
      final response = await http.post(
        url,
        headers: header,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'name': name,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['errors'] != null) {
        throw HttpException(responseData['errors']['message']);
      }
      _token = responseData['token'];
      _autoLogout();
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //if store multiple data in shared preferences then call this method
    // prefs.remove();
    //only user data
    prefs.clear();
  }

  void _autoLogout() {
    if (info == false) {
      logout();
    }
  }
}
