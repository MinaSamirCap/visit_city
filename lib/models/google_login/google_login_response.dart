import '../../models/rate/user_model.dart';

class GoogleLoginResponse {
  final String token;
  final UserModel user;

  GoogleLoginResponse(this.token, this.user);

  GoogleLoginResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = (json['user'] != null) ? UserModel.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
      };
}