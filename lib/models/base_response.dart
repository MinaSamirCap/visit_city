abstract class BaseResponse {
  bool info;
  MessageModel message;

  BaseResponse.fromJson(Map<String, dynamic> json) : info = json['info'];

  Map<String, dynamic> toJson() => {'info': info};
}

class MessageModel {
  int messageId;
  String messageType;
  String message;
}
