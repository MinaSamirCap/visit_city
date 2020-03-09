class LoginSendModel {
   String username;
   String password;

  LoginSendModel({this.username, this.password});

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
