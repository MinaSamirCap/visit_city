import '../../models/sights_list/sights_list_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class SightsListWrapper extends BaseWrapper {
  final SightsListResponse data;

  SightsListWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  SightsListWrapper.fromJson(Map<String, dynamic> json)
      : data = SightsListResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
