import '../base_wrapper.dart';
import '../message_model.dart';
import 'google_login_response.dart';

class GoogleLoginWrapper extends BaseWrapper {
  final GoogleLoginResponse data;

  GoogleLoginWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  GoogleLoginWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] != null)
            ? GoogleLoginResponse.fromJson(json['data'])
            : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}