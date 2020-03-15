class FbLoginSendModel {
  String accessToken;

  FbLoginSendModel({this.accessToken});

  FbLoginSendModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'];

  Map<String, dynamic> toJson() => {'accessToken': accessToken};
}
