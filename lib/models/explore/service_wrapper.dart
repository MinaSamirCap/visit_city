import '../../models/explore/explore_model.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class ServiceWrapper extends BaseWrapper {
  final ExploreModel data;

  ServiceWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  ServiceWrapper.fromJson(Map<String, dynamic> json)
      : data =
            (json['data'] != null) ? ExploreModel.fromJson(json['data']) : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
