import '../../models/wishlist/wishlist_response.dart';
import '../base_wrapper.dart';
import '../message_model.dart';

class WishlistWrapper extends BaseWrapper {
  final WishlistResponse data;

  WishlistWrapper(this.data, bool info, MessageModel messageModel)
      : super(info, messageModel);

  WishlistWrapper.fromJson(Map<String, dynamic> json)
      : data = WishlistResponse.fromJson(json['data']),
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'data': data.toJson(), 'info': info, 'message': message.toJson()};
}
