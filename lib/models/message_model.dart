import 'dart:io';

class MessageModel {
  final int messageId;
  final String messageType;
  final String message;

  MessageModel(this.messageId, this.messageType, this.message);

  MessageModel.fromJson(Map<String, dynamic> json)
      : messageId = json['messageId'],
        messageType = json['messageType'],
        message = json['message'];

  Map<String, dynamic> toJson() =>
      {'messageId': messageId, 'messageType': messageType, 'message': message};

  static MessageModel getJsonMessage() {
    return MessageModel(6001, "jsonException", "Json Parse Exception");
  }

  static MessageModel getDecodeError() {
    return MessageModel(
        6003, "decodeError", "Json Decode Error ... Api may be not send Json");
  }

  static MessageModel getUnknownError() {
    return MessageModel(6004, "unknownError", "Unknow Error");
  }

  static MessageModel getHttpException(HttpException error) {
    return MessageModel(6002, error.message, error.message);
  }

  static MessageModel getTypeError(TypeError error) {
    return getJsonMessage();
  }
}

/// reference
/// https://flutter.dev/docs/development/data-and-backend/json
/// https://www.raywenderlich.com/4038868-parsing-json-in-flutter
