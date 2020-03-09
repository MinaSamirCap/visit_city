import '../../models/unplan_sight_model.dart/unplan_sight_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class UnplanSightWrapper extends BaseWrapper {
  final UnplanSightResponse data;

  UnplanSightWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  UnplanSightWrapper.fromJson(Map<String, dynamic> json)
      : data = UnplanSightResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
