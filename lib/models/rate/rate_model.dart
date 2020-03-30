import '../../models/rate/user_model.dart';

class RateModel {
  final int id;
  final UserModel user;
  final String subjectType;
  final int subjectId;
  final double rate;
  final String comment;
  final String createdAt;
  final String updatedAt;

  RateModel(
    this.id,
    this.user,
    this.subjectType,
    this.subjectId,
    this.rate,
    this.comment,
    this.createdAt,
    this.updatedAt,
  );

  RateModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = UserModel.fromJson(json['user']),
        subjectType = json['subjectType'],
        subjectId = json['subjectId'],
        rate = double.parse(json['rate'].toString()),
        comment = json['comment'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'subjectType': subjectType,
        'subjectId': subjectId,
        'rate': rate,
        'comment': comment,
        'createdAt': createdAt,
        'updatedAt': updatedAt
      };

  static RateModel quickRate(
      String userName, String photo, double rate, String comment) {
    return RateModel(null, UserModel.quickUser(userName, photo), null, null,
        rate, comment, null, null);
  }
}
