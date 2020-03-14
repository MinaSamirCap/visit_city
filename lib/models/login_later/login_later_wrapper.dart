import '../base_wrapper.dart';
import '../message_model.dart';
import 'login_later_response.dart';

class LoginLaterWrapper extends BaseWrapper {
  final LoginLaterResponse data;

  LoginLaterWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  LoginLaterWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] != null)
            ? LoginLaterResponse.fromJson(json['data'])
            : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}