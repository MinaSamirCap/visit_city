import '../../models/itineraries/day_model.dart';
import '../../models/itineraries/itineraries_model.dart';

class ItinerariesResponse extends ItinerariesModel {
  List<DayModel> daysList;

  ItinerariesResponse(this.daysList, id, name, nameAr, nameEn, desc, descAr,
      descEn, days, type, createdAt, updatedAt)
      : super(id, name, nameAr, nameEn, desc, descAr, descEn, days, type,
            createdAt, updatedAt);

  ItinerariesResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    daysList = (json['sights'] as List).map((item) {
      return DayModel.fromJson(item);
    }).toList();
  }
}
