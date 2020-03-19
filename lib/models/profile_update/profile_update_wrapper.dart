import '../base_wrapper.dart';
import '../message_model.dart';

class ProfileUpdateWrapper extends BaseWrapper {
  ProfileUpdateWrapper(bool info, MessageModel messageModel)
      : super(info, messageModel);

  ProfileUpdateWrapper.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  Map<String, dynamic> toJson() => {'info': info, 'message': message.toJson()};
}