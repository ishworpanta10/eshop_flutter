import 'package:dio/dio.dart';
import 'package:e_shop_flutter_api/model/model.dart';

class ApiService {
  final url = "https://ishwor-node-eshop-test-api.herokuapp.com/api/v1/products";

  Future<List<ProductModel>> getAllProductList() async {
    var productList = <ProductModel>[];
    try {
      var response = await Dio().get(url);
      // final data = response[""]
      if (response.statusCode == 200) {
        print("Product List : ${response.data["productList"]}");
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
}
