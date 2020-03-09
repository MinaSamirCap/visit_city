import '../../models/profile/profile_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class ProfileWrapper extends BaseWrapper {
  final ProfileResponse data;

  ProfileWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  ProfileWrapper.fromJson(Map<String, dynamic> json)
      : data = ProfileResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
