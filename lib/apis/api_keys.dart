import 'package:visit_city/prefs/pref_manager.dart';

class ApiKeys {
  static Future<Map<String, String>> getAuthHeaders() async {
    return {
      contentType: applicationJson,
      acceptLanguage: await PrefManager.getLang()
    };
  }

  static Future<Map<String, String>> getHeaders() async {
    return {
      authorization: '$keyBearer ${await PrefManager.getToken()}',
      contentType: applicationJson,
      acceptLanguage: await PrefManager.getLang()
    };
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
