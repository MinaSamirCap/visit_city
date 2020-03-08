import 'package:visit_city/models/sight/category_model.dart';

import '../../models/explore/open_hour_model.dart';

class SightResponse {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  List<String> photos;
  final String desc;
  final String descAr;
  final String descEn;
  final double rate;
  final int reviews;
  List<double> location;
  final OpenHourModel openHours;
  final String price;
  final String contact;
  final String website;
  final String qr;
  final String createdAt;
  final String updatedAt;
  final bool like;
  final bool plan;
  List<CategoryModel> categories;

  SightResponse(
      this.id,
      this.name,
      this.nameAr,
      this.nameEn,
      this.photos,
      this.desc,
      this.descAr,
      this.descEn,
      this.rate,
      this.reviews,
      this.location,
      this.openHours,
      this.price,
      this.contact,
      this.website,
      this.qr,
      this.createdAt,
      this.updatedAt,
      this.like,
      this.plan,
      this.categories);

  SightResponse.fromJson(Map<String, dynamic> json)
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
        rate = double.parse(json['rate'].toString()),
        reviews = json['reviews'],
        location = (json['location'] as List).map((item) {
          return item as double;
        }).toList(),
        openHours = OpenHourModel.fromJson(json['openHours']),
        price = json['price'],
        contact = json['contact'],
        website = json['website'],
        qr = json['QR'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        like = json['like'],
        plan = json['plan'],
        categories = (json['categories'] as List).map((item) {
          return CategoryModel.fromJson(item);
        }).toList();

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
        'rate': rate,
        'reviews': reviews,
        'location': location.map((item) {
          return item;
        }).toList(),
        'openHours': openHours.toJson(),
        'price': price,
        'contact': contact,
        'website': website,
        'QR': qr,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'like': like,
        'plan': plan,
        'categories': categories.map((item) {
          return item.toJson();
        }).toList()
      };
}
