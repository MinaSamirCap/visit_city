import '../../models/itineraries/open_hours_model.dart';

class SightModel {
  final int id;
  final String name;
  List<String> photos;
  final String desc;
  final String descAr;
  final String descEn;
  final double rate;
  final int reviews;
  List<double> location;
  List<String> services;
  final OpenHourModel openHours;
  final String price;
  final String contact;
  final String website;
  final String qr;
  final String createdAt;
  final String updatedAt;
  final String way;
  final String how;

  SightModel({
    this.id,
    this.name,
    this.desc,
    this.descAr,
    this.descEn,
    this.rate,
    this.reviews,
    this.location,
    this.price,
    this.contact,
    this.website,
    this.qr,
    this.createdAt,
    this.updatedAt,
    this.photos,
    this.services,
    this.openHours,
    this.way,
    this.how,
  });

  SightModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        desc = json['desc'],
        descAr = json['descAr'],
        descEn = json['descEn'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        rate = double.parse(json['rate'].toString()),
        reviews = json['reviews'],
        price = json['price'],
        contact = json['contact'],
        website = json['website'],
        qr = json['QR'],
        way = json['way'],
        how = json['how'],
        openHours = OpenHourModel.fromJson(json['openHours']),
        photos = (json['photos'] as List).map((item) {
          return item as String;
        }).toList(),
        services = (json['services'] as List).map((item) {
          return item as String;
        }).toList(),
        location = (json['location'] as List).map((item) {
          return item as double;
        }).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'desc': desc,
        'nameEn': descAr,
        'nameAr': descEn,
        'descAr': descAr,
        'descEn': descEn,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'rate': rate,
        'price': price,
        'contact': contact,
        'website': website,
        'QR': qr,
        'way': way,
        'how': how,
        'reviews': reviews,
        'openHours': openHours.toJson(),
        'photos': photos.map((item) {
          return item;
        }).toList(),
        'location': location.map((item) {
          return item;
        }).toList(),
        'services': services.map((item) {
          return item;
        }).toList(),
      };
}
