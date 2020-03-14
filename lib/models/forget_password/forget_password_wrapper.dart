import '../base_wrapper.dart';
import '../message_model.dart';

class ForgetPasswordWrapper extends BaseWrapper {
  ForgetPasswordWrapper(bool info, MessageModel messageModel)
      : super(info, messageModel);

  ForgetPasswordWrapper.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  Map<String, dynamic> toJson() => {'info': info, 'message': message.toJson()};
}
