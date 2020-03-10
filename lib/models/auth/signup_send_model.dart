class SignupSendModel {
  String name;
  String email;
  String password;
  String phone;
  String country;

  SignupSendModel(
      {this.name, this.email, this.password, this.phone, this.country});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'country': country
      };
}
