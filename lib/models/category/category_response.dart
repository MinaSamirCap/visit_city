class CategoryResponse {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String logo;
  final String createdAt;
  final String updatedAt;

  CategoryResponse(this.id, this.name, this.nameAr, this.nameEn,this.logo, this.createdAt,
      this.updatedAt);

  CategoryResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        nameAr = json['nameAr'],
        nameEn = json['nameEn'],
        logo = json['logo'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'logo': logo,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}