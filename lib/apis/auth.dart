import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/lang/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  final header = {'Content-Type': 'application/json'};

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(String email, String password, String url) async {
    try {
      print('okay');
      final response = await http.post(
        url,
        headers: header,
        body: json.encode(
          {'username': email, 'password': password},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['errors'] != null) {
        throw HttpException(responseData['errors']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['user']['id'];
      _expiryDate = DateTime.now().add(
        Duration(
          days: int.parse(responseData['user']['expiresIn']),
        ),
      );
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode([
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String()
        }
      ]);
      prefs.setString('userData', userData);

      print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin () async{
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.encode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> signIn(String email, String password) async {
    const url = 'https://visit-fayoum.herokuapp.com/api/v1/login';
    return authenticate(email, password, url);
  }

  Future<void> signUp(String email, String password) async {
    const url = 'https://visit-fayoum.herokuapp.com/api/v1/signup';
    return authenticate(email, password, url);
  }

  Future<void> logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;
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
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inDays;
    _authTimer = Timer(Duration(days: timeToExpiry), logout);
  }
}
