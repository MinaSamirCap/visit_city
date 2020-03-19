import '../../models/rate/user_model.dart';

class FbLoginResponse {
  final String token;
  final UserModel user;

  FbLoginResponse(this.token, this.user);

  FbLoginResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = (json['user'] != null) ? UserModel.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
      };
}