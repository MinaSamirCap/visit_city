import '../base_wrapper.dart';
import '../message_model.dart';

class LikeDislikeWrapper extends BaseWrapper {
  LikeDislikeWrapper(bool info, MessageModel messageModel)
      : super(info, messageModel);

  LikeDislikeWrapper.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  Map<String, dynamic> toJson() => {'info': info, 'message': message.toJson()};
}
