import '../base_wrapper.dart';
import '../message_model.dart';

class RatePostWrapper extends BaseWrapper {
  RatePostWrapper(bool info, MessageModel messageModel)
      : super(info, messageModel);

  RatePostWrapper.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  Map<String, dynamic> toJson() => {'info': info, 'message': message.toJson()};
}
