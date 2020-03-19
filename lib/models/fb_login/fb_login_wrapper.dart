import '../base_wrapper.dart';
import '../message_model.dart';
import 'fb_login_response.dart';

class FbLoginWrapper extends BaseWrapper {
  final FbLoginResponse data;

  FbLoginWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  FbLoginWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] != null)
            ? FbLoginResponse.fromJson(json['data'])
            : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
