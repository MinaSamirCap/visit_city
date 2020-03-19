class FeedbackSendModel {
  final int rate;
  final String comment;

  FeedbackSendModel(this.rate, this.comment);

  FeedbackSendModel.fromJson(Map<String, dynamic> json)
      : rate = json['rate'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {'rate': rate, 'comment': comment};
}
