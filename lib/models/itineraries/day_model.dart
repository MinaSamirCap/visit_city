import '../../models/itineraries/sight_model.dart';

class DayModel {
  final int day;
  List<SightModel> sightsDay;

  DayModel({this.day, this.sightsDay});

  DayModel.fromJson(Map<String, dynamic> json)
      : day = json['day'],
        sightsDay = (json['sights'] as List).map((item) {
          return SightModel.fromJson(item);
        }).toList();

  Map<String, dynamic> toJson() => {
        'day': day,
        'sights': sightsDay.map((item) {
          return item.toJson();
        }).toList(),
      };
}
