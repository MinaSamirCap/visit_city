import '../../models/plan/plan_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class PlanWrapper extends BaseWrapper {
  final PlanResponse data;

  PlanWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  PlanWrapper.fromJson(Map<String, dynamic> json)
      : data = PlanResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
