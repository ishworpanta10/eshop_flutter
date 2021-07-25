class UserModel {
  final String name;
  final String email;
  final int phone;
  final String? image;
  final String? street;
  final String? apartment;
  final String? city;
  final String? zip;
  final String? country;
  final bool? isAdmin;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.street,
    this.apartment,
    this.city,
    this.zip,
    this.country,
    this.isAdmin,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
      street: json["street"],
      apartment: json["apartment"],
      city: json["city"],
      zip: json["zip"],
      country: json["country"],
      isAdmin: json["isAdmin"],
    );
  }
}
