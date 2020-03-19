import '../../models/rate/user_model.dart';

class LoginLaterResponse {
  final String token;
  final UserModel user;

  LoginLaterResponse(this.token, this.user);

  LoginLaterResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = (json['user'] != null) ? UserModel.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
      };
}