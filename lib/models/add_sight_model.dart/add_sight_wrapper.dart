import '../../models/add_sight_model.dart/add_sight_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class AddSightWrapper extends BaseWrapper {
  final AddSightResponse data;

  AddSightWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  AddSightWrapper.fromJson(Map<String, dynamic> json)
      : data = AddSightResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
