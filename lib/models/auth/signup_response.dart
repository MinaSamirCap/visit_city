import 'signup_user_model.dart';

class SignupResponse {
  final String token;
  final SignupUserModel user;

  SignupResponse(this.token, this.user);

  SignupResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = SignupUserModel.fromJson(json['user']);

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user.toJson(),
      };
}