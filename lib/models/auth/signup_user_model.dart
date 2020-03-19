class SignupUserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String country;
  final bool active;
  final bool enabled;
  final String role;
  final String createdAt;
  final String updatedAt;

  SignupUserModel(this.id, this.name, this.email, this.phone, this.country,
      this.active, this.enabled, this.role, this.createdAt, this.updatedAt);

  SignupUserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
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
        'email': email,
        'phone': phone,
        'country': country,
        'active': active,
        'enabled': enabled,
        'role': role,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  static SignupUserModel quickUser(String userName, String photo) {
    return SignupUserModel(
        null, userName, null, null, null, null, null, null, null, null);
  }
}
