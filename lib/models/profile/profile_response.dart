class ProfileResponse {
  final int id;
  final String name;
  final String photo;
  final String email;
  final String phone;
  final String country;

  ProfileResponse({
    this.id,
    this.name,
    this.photo,
    this.email,
    this.phone,
    this.country,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        photo = json['photo'],
        email = json['email'],
        phone = json['phone'],
        country = json['country'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'photo': photo,
        'email': email,
        'phone': phone,
        'country': country,
      };
}
