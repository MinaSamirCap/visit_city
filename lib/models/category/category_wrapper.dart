import '../base_wrapper.dart';
import '../message_model.dart';
import 'category_response.dart';

class CategoryWrapper extends BaseWrapper {
  final List<CategoryResponse> data;

  CategoryWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  CategoryWrapper.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List).map((item) {
          CategoryWrapper.fromJson(item);
        }).toList(),
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'data': data.map((item) {
          item.toJson();
        }),
        'info': info,
        'message': message.toJson()
      };
}
