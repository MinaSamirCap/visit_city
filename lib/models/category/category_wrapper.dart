import '../base_wrapper.dart';
import '../message_model.dart';
import 'category_response.dart';

class CategoryWrapper extends BaseWrapper {
  List<CategoryResponse> data;

  CategoryWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  CategoryWrapper.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if ((json['data'] as List) != null) {
      data = (json['data'] as List).map((item) {
        return CategoryResponse.fromJson(item);
      }).toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((item) {
          return item.toJson();
        }).toList(),
        'info': info,
        'message': message.toJson()
      };
}
