import '../../models/sight/sight_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class SightWrapper extends BaseWrapper {
  final SightResponse data;

  SightWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  SightWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] != null)
            ? SightResponse.fromJson(json['data'])
            : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
