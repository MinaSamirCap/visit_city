import '../../models/rate/user_model.dart';

class LoginResponse {
  final String token;
  final UserModel user;

  LoginResponse(this.token, this.user);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = (json['user'] != null) ? UserModel.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
      };
}
