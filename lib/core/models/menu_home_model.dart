class MenuHomeModel {
  String? label;
  String? url;
  String? color;
  List<MenuHomeModel>? items;

  MenuHomeModel({this.label, this.url, this.color, this.items});

  MenuHomeModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
    color = json['color'];
    items = json['items'] == null
        ? []
        : (json['items'] as List)
            .map((e) => MenuHomeModel.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['url'] = url;
    data['color'] = color;
    data['items'] = items;
    return data;
  }
}
