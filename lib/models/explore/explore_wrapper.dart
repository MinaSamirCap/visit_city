import '../../models/explore/explore_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class ExploreWrapper extends BaseWrapper {
  final ExploreResponse data;

  ExploreWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  ExploreWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] != null)
            ? ExploreResponse.fromJson(json['data'])
            : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
