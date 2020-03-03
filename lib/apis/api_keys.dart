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

  static String getToken() {
    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyUm9sZSI6Im5vcm1hbCIsImlhdCI6MTU4MzE3OTI5MCwiZXhwIjoxNTg0NDc1MjkwfQ.l0yS_ysHXxrdrF1eRsRoNg1kaCbig5ZxifWlJBj4oTE';
  }

  static final baseUrl = 'https://visit-fayoum.herokuapp.com/api/v1';
  static final feedbackUrl = baseUrl + "/feedbacks";
  static final categoriesUrl = baseUrl + "/categories";
  static final exploreUrl = baseUrl + "/services-explored?";
  static final wishlistUrl = baseUrl + "/wishlist?";

}
