import '../../models/rate/rate_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class RateWrapper extends BaseWrapper {
  final RateResponse data;

  RateWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  RateWrapper.fromJson(Map<String, dynamic> json)
      : data =
            (json['data'] != null) ? RateResponse.fromJson(json['data']) : null,
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
