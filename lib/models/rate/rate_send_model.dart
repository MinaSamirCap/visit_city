class RateSendModel {
  final int rate;
  final String comment;

  RateSendModel(this.rate, this.comment);

  Map<String, dynamic> toJson() => {'rate': rate, 'comment': comment};
}
