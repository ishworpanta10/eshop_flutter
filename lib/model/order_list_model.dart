class OrderListModel {
  final String userId;
  final List<String> orderItems;
  final String shippingAddress1;
  final String city;
  final String phone;
  final num totalPrice;
  final String dateOrdered;

  OrderListModel({
    required this.userId,
    required this.orderItems,
    required this.shippingAddress1,
    required this.city,
    required this.phone,
    required this.totalPrice,
    required this.dateOrdered,
  });

  factory OrderListModel.fromMap(Map<String, dynamic> json) {
    return OrderListModel(
      userId: json["user"],
      orderItems: json["orderItems"].cast<String>(),
      shippingAddress1: json["shippingAddress1"],
      city: json["city"],
      phone: json["phone"],
      totalPrice: json["totalPrice"],
      dateOrdered: json["dateOrdered"],
    );
  }
}
