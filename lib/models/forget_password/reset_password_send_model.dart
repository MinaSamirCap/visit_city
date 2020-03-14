class ResetPasswordSendModel {
  String password;
  String code;

  ResetPasswordSendModel({this.password, this.code});

  ResetPasswordSendModel.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        code = json['code'];

  Map<String, dynamic> toJson() => {'password': password, 'code': code};
}
