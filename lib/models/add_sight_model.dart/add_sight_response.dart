class AddSightResponse {
  int id;
  int user;
  List<int> sights;

  AddSightResponse(this.id, this.sights, this.user);

  AddSightResponse.fromJson(Map<String, dynamic> json)
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
