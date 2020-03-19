class UserModel {
  final int id;
  final String name;
  final String photo;
  final String email;
  final String phone;
  final String country;
  final bool active;
  final bool enabled;
  final String role;
  final String createdAt;
  final String updatedAt;

  UserModel(
      this.id,
      this.name,
      this.photo,
      this.email,
      this.phone,
      this.country,
      this.active,
      this.enabled,
      this.role,
      this.createdAt,
      this.updatedAt);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        photo = json['photo'],
        email = json['email'],
        phone = json['phone'],
        country = json['country'],
        active = json['active'],
        enabled = json['enabled'],
        role = json['role'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'photo': photo,
        'email': email,
        'phone': phone,
        'country': country,
        'active': active,
        'enabled': enabled,
        'role': role,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  static UserModel quickUser(String userName, String photo) {
    return UserModel(
        null, userName, photo, null, null, null, null, null, null, null, null);
  }
}
