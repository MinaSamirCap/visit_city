class UnplanSightResponse {
  int id;
  int user;
  List<int> sights;

  UnplanSightResponse(this.id, this.sights, this.user);

  UnplanSightResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        sights = (json['sights'] as List).map((item) {
          return item as int;
        }).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'sights': sights.map((item) {
          return item;
        }).toList(),
      };
}
