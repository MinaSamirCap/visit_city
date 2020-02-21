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
}
