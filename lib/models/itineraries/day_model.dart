class DayModel {
  final int id;
  List<dynamic> sightsDay;
  DayModel({this.id, this.sightsDay});

  DayModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sightsDay = (json['sights'] as List).map((item) {
          return item as List;
        }).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'photos': sightsDay.map((item) {
          return item;
        }).toList(),
      };
}
