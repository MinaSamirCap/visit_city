

class ItinerariesModel {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String desc;
  final String descAr;
  final String descEn;
  final int days;
  final String type;
  final String createdAt;
  final String updatedAt;
  List<dynamic> sights;

  ItinerariesModel({
    this.id,
    this.name,
    this.nameAr,
    this.nameEn,
    this.desc,
    this.descAr,
    this.descEn,
    this.days,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.sights,
  });

  
  ItinerariesModel.fromJson(Map<String, dynamic> json) 
    : id = json['id'],
      name = json['name'],
      nameAr = json['nameAr'],
      nameEn = json['nameEn'],
      desc = json['desc'],
      descAr = json['descAr'],
      descEn = json['descEn'],
      days = json['days'],
      type = json['type'],
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'],
      sights = (json['sights'] as List).map((item) {
        return item as List;
      }).toList();
    
  

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameAr': nameAr,
        'nameEn': nameEn,
        'desc': desc,
        'descAr': descAr,
        'descEn': descEn,
        'days': days,
        'type': type,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'sights': sights.map((item) {
          return item;
        }).toList(),
      };
}
