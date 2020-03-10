import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiKeys {
  static Map<String, String> _headers = {
    authorization: '$keyBearer ${getToken()}',
    contentType: applicationJson,
    acceptLanguage: getLanguage()
  };
  static Map<String, String> _authHeaders = {
    contentType: applicationJson,
    acceptLanguage: getLanguage()
  };

  static Map<String, String> getAuthHeaders() {
    return _authHeaders;
  }

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

  static String getToken() {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyUm9sZSI6Im5vcm1hbCIsImlhdCI6MTU4MzcwMTI3NywiZXhwIjoxNTg0OTk3Mjc3fQ.WSWQ3Tpt93aToJS-BXMvXvnCoCDt2m7ZSlk04pFDvr8";
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
  static final profileUrl = baseUrl + "/profile";
  static final getPlanUrl = baseUrl + "/my-plan?";
  static final addPlan = baseUrl + "/plan-itinerary/";
  static final addSight = baseUrl + "/plan-sights";
  static final removeSight = baseUrl + "/unplan-sights";
  static final servicesReviewUrl = baseUrl + "/reviews/service/";
  static final mixedItinerary = baseUrl + "/itineraries-mixed";
  static final sightsReviewUrl = baseUrl + "/reviews/sight/";
  static final loginUrl = baseUrl + "/login";
  static final signupUrl = baseUrl + "/signup";
}
