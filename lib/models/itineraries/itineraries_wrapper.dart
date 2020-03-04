import 'itineraries_model.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class ItinerariesWrapper extends BaseWrapper {
  final ItinerariesModel data;

  ItinerariesWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  ItinerariesWrapper.fromJson(Map<String, dynamic> json)
      : data = ItinerariesModel.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
