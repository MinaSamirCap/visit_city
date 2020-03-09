import '../base_wrapper.dart';
import '../message_model.dart';
import 'login_response.dart';

class LoginWrapper extends BaseWrapper {
  final LoginResponse data;

  LoginWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  LoginWrapper.fromJson(Map<String, dynamic> json)
      : data = LoginResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
