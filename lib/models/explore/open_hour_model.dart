import 'dart:io';

class OpenHourModel {
  final String from;
  final String to;

  OpenHourModel(this.from, this.to);

  OpenHourModel.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        to = json['to'];

  Map<String, dynamic> toJson() => {'from': from, 'to': to};
}
