class ProfileSendModel {
  String name;
  String email;
  String phone;
  String country;

  ProfileSendModel({this.name, this.email, this.phone, this.country});
  
  ProfileSendModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        phone = json['phone'],
        country = json['country'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'phone': phone, 'country': country};
}
