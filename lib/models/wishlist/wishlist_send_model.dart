class WishlistSendModel {
  final List<int> ids;

  WishlistSendModel(this.ids);

  Map<String, dynamic> toJson() => {
        'sights': ids.map((item) {
          return item;
        }).toList(),
      };
}
