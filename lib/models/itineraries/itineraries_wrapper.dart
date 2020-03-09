import '../../models/itineraries/itineraries_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class ItinerariesWrapper extends BaseWrapper {
  final ItinerariesResponse data;

  ItinerariesWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  ItinerariesWrapper.fromJson(Map<String, dynamic> json)
      : data = ItinerariesResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
