class FeedbackResponse {
  final int id;
  final int user;
  final int rate;
  final String comment;
  final String createdAt;
  final String updatedAt;

  FeedbackResponse(this.id, this.user, this.rate, this.comment, this.createdAt,
      this.updatedAt);

  FeedbackResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        rate = json['rate'],
        comment = json['comment'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'rate': rate,
        'comment': comment,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };
}
