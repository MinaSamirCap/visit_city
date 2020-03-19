class GoogleLoginSendModel {
  String idToken;

  GoogleLoginSendModel({this.idToken});

  GoogleLoginSendModel.fromJson(Map<String, dynamic> json)
      : idToken = json['idToken'];

  Map<String, dynamic> toJson() => {'idToken': idToken};
}
