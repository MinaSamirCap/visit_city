class SightsModel {
  final List<Sight> sights;

  SightsModel({this.sights});

  SightsModel.fromJson(Map<String, dynamic> json)
      : sights = (json['sights'] as List).map((item) {
          return item as Sight;
        }).toList();

  Map<String, dynamic> toJson() => {'sights': sights};
}

class Sight {
  final int day;
  final List<SightsDetails> sights;

  Sight({
    this.day,
    this.sights,
  });

  factory Sight.fromJson(Map<String, dynamic> json) {
    return new Sight(
      day: json['day'],
      sights: (json['sights'] as List).map((item) {
        return item as SightsDetails;
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'sights': sights.map((item) {
          return item;
        }).toList(),
      };
}

class SightsDetails {
  final int id;
  final String name;
  List<String> photos;
  List<String> services;
  final String way;
  final String how;

  SightsDetails({
    this.id,
    this.name,
    this.photos,
    this.services,
    this.way,
    this.how,
  });

  factory SightsDetails.fromJson(Map<String, dynamic> json) {
    return new SightsDetails(
      id: json['id'],
      name: json['name'],
      photos: (json['photos'] as List).map((photos) {
        return photos as String;
      }).toList(),
    );
  }
}
