import 'package:dio/dio.dart';
import 'package:e_shop_flutter_api/model/model.dart';
import 'package:e_shop_flutter_api/model/order_list_model.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';

class ApiService {
  final dio = Dio();
  final productUrl = "https://ishwor-node-eshop-test-api.herokuapp.com/api/v1/products";
  final orderUrl = "https://ishwor-node-eshop-test-api.herokuapp.com/api/v1/orders";

  Future<List<ProductModel>> getAllProductList() async {
    var productList = <ProductModel>[];
    try {
      var response = await dio.get(productUrl);
      // final data = response[""]
      if (response.statusCode == 200) {
        // print("Product List : ${response.data["productList"]}");
        final data = response.data["productList"] as List;
        productList = data.map((productModel) => ProductModel.fromMap(productModel)).toList();
        // print("Product Length :  ${productList.length}");

        return productList;
      } else {
        print("${response.statusCode} : ${response.statusMessage}");
      }
    } catch (e) {
      print(e);
    }
    return productList;
  }

  Future<List<OrderListModel>> getAllOrdersList() async {
    var orderList = <OrderListModel>[];
    try {
      final token = Constants.prefs!.getString(Constants.tokenSP);
      print("Token in Order : $token");
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get(orderUrl);
      // final data = response[""]
      if (response.statusCode == 200) {
        // print("Product List : ${response.data["productList"]}");
        final data = response.data["orderList"] as List;
        orderList = data.map((orderListModel) => OrderListModel.fromMap(orderListModel)).toList();
        print("Order Length :  ${orderList.length}");
        print("Order Length :  ${orderList[0].userId}");

        // return orderList;
      } else {
        print("${response.statusCode} : ${response.statusMessage}");
      }
    } catch (e) {
      print(e);
    }
    return orderList;
  }
}
