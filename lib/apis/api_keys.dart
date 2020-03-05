import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiKeys {
  static Map<String, String> _headers = {
    authorization: '$keyBearer ${getToken()}',
    contentType: applicationJson,
    acceptLanguage: getLanguage()
  };

  static Map<String, String> getHeaders() {
    return _headers;
  }

  static final authorization = "Authorization";
  static final contentType = "Content-Type";
  static final applicationJson = "application/json";
  static final acceptLanguage = "accept-language";
  static final keyBearer = "Bearer";
  static final arLang = "ar";
  static final enLang = "en";

  static final limitKey = "limit";
  static final limitValue = "15";
  static final pageKey = "page";
  static final categoryKey = "category";

  static String getLanguage() {
    return enLang;
  }

  static String getToken(){
    
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyUm9sZSI6Im5vcm1hbCIsImlhdCI6MTU4MzQwOTQ3MywiZXhwIjoxNTg0NzA1NDczfQ.zZZaVsOhh9mRnzByTSnbQ6Sp2nOushqyCYgsQ89btCw";
  }
  // static Future<String> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) {
  //     return "";
  //   }
  //   final extractedUserData =
  //       json.decode(prefs.getString('userData')) as Map<String, dynamic>;
  //       final String token = extractedUserData['token'];
  //   return token;
  // }

  static final baseUrl = 'https://visit-fayoum.herokuapp.com/api/v1';
  static final feedbackUrl = baseUrl + "/feedbacks";
  static final categoriesUrl = baseUrl + "/categories";
  static final exploreUrl = baseUrl + "/services-explored?";
  static final itinerariesUrl = baseUrl + '/itineraries';
  static final wishlistUrl = baseUrl + "/wishlist?";
  static final likeDislikeUrl = baseUrl + "/wishlist?";
  static final sightDetailsUrl = baseUrl + "/sights/";
  static final exploreDetailsUrl = baseUrl + "/services/";

}
