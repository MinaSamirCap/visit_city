import '../../models/category/category_response.dart';
import '../../models/explore/open_hour_model.dart';

class ExploreModel {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  List<String> photos;
  final String desc;
  final String descAr;
  final String descEn;
  final CategoryResponse categoryId;
  final double rate;
  final int reviews;
  List<double> location;
  final OpenHourModel openHours;
  final String price;
  final String createdAt;
  final String updatedAt;

  ExploreModel(
      this.id,
      this.name,
      this.nameAr,
      this.nameEn,
      this.photos,
      this.desc,
      this.descAr,
      this.descEn,
      this.categoryId,
      this.rate,
      this.reviews,
      this.location,
      this.openHours,
      this.price,
      this.createdAt,
      this.updatedAt);

  ExploreModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        nameAr = json['nameAr'],
        nameEn = json['nameEn'],
        photos = (json['photos'] as List).map((item) {
          return item as String;
        }).toList(),
        desc = json['desc'],
        descAr = json['descAr'],
        descEn = json['descEn'],
        categoryId = CategoryResponse.fromJson(json['categoryId']),
        rate = double.parse(json['rate'].toString()),
        reviews = json['reviews'],
        location = (json['location'] as List).map((item) {
          return item as double;
        }).toList(),
        openHours = OpenHourModel.fromJson(json['openHours']),
        price = json['price'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'photos': photos.map((item) {
          return item;
        }).toList(),
        'desc': desc,
        'descAr': descAr,
        'descEn': descEn,
        'categoryId': categoryId.toJson(),
        'rate': rate,
        'reviews': reviews,
        'location': location.map((item) {
          return item;
        }).toList(),
        'openHours': openHours.toJson(),
        'price': price,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}
