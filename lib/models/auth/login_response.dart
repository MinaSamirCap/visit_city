import '../../models/rate/user_model.dart';

class LoginResponse {
  final String token;
  final UserModel user;

  LoginResponse(this.token, this.user);

  LoginResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = UserModel.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
      };
}
