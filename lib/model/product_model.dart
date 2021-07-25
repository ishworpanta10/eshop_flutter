import 'package:e_shop_flutter_api/model/category_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String? richDescription;
  final String? image;
  final List<String>? imageList;
  final String? brand;
  final int price;
  final int? rating;
  final int? numReviews;
  final int countInStock;
  final String? dateCreated;
  final CategoryModel category;
  final bool isFeatured;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.richDescription,
    this.image,
    this.imageList,
    this.brand,
    required this.price,
    this.rating,
    this.numReviews,
    required this.countInStock,
    this.dateCreated,
    required this.category,
    required this.isFeatured,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      richDescription: json["richDescription"],
      image: json["image"],
      imageList: json["imageList"],
      brand: json["brand"],
      price: json["price"],
      rating: json["rating"],
      numReviews: json["numReviews"],
      countInStock: json["countInStock"],
      dateCreated: json["dateCreated"],
      // category: (json["category"]).map((e) => CategoryModel.fromMap(e)).toList().cast<CategoryModel>(),
      category: CategoryModel.fromMap(json["category"]),
      isFeatured: json["isFeatured"],
    );
  }
}
