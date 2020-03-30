import '../base_wrapper.dart';
import '../message_model.dart';
import 'feedback_response.dart';

class FeedbackWrapper extends BaseWrapper {
  final FeedbackResponse data;

  FeedbackWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  FeedbackWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] != null)
            ? FeedbackResponse.fromJson(json['data'])
            : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}