class ForgetPasswordSendModel {
  String email;

  ForgetPasswordSendModel({this.email});

  ForgetPasswordSendModel.fromJson(Map<String, dynamic> json)
      : email = json['email'];

  Map<String, dynamic> toJson() => {'email': email};
}
