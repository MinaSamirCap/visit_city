import 'message_model.dart';

abstract class BaseWrapper {
  final bool info;
  final MessageModel message;

  BaseWrapper(this.info, this.message);

  BaseWrapper.fromJson(Map<String, dynamic> json)
      : info = json['info'],
        message = MessageModel.fromJson(json['message']);

  String getInfo() => "'info': $info";
  String getMessage() => "'message': ${message.toJson()}";

  Map<String, dynamic> toJson();
}
