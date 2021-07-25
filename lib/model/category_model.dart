class CategoryModel {
  final String? name;
  final String? color;
  final String? image;

  CategoryModel({this.name, this.color, this.image});

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"],
      color: json["color"],
      image: json['image'] != null ? json['image'] : [],
    );
  }
}
