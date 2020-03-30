
import '../../models/rate/user_model.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class ProfileWrapper extends BaseWrapper {
  final UserModel data;

  ProfileWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  ProfileWrapper.fromJson(Map<String, dynamic> json)
      : data = UserModel.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
