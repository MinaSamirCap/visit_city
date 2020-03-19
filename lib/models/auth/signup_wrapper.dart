import '../base_wrapper.dart';
import '../message_model.dart';
import 'signup_response.dart';

class SignupWrapper extends BaseWrapper {
  final SignupResponse data;

  SignupWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  SignupWrapper.fromJson(Map<String, dynamic> json)
      : data = SignupResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}