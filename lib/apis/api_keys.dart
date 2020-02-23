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

  static String getLanguage() {
    return arLang;
  }

  static String getToken() {
    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..HEUxYZ905vH8za-EfQ-U1riCn1VHJUB4eYgK8Ozjoeo';
  }

  static final baseUrl = 'https://visit-fayoum.herokuapp.com/api/v1';
  static final feedbackUrl = baseUrl + "/feedbacks";
}
