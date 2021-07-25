import 'package:dio/dio.dart';
import 'package:e_shop_flutter_api/model/auth/login_api_response_model.dart';

class AuthService {
  final loginUrl = "https://ishwor-node-eshop-test-api.herokuapp.com/api/v1/users/login";
  final registerUrl = "https://ishwor-node-eshop-test-api.herokuapp.com/api/v1/users/register";
  final dio = Dio();
  Future<AuthApiResponseModel> loginWithCredAndGetToken({required String email, required String password}) async {
    var response = await dio.post(loginUrl, data: {"email": email, "password": password});
    // print("Status Code : ${response.data}");
    return AuthApiResponseModel.fromMap(response.data);
  }

  Future<AuthApiResponseModel> registerWithEmailAndPasswordAndGetToken({required String email, required String password, required String name, required String phone}) async {
    var response = await dio.post(registerUrl, data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": int.parse(phone),
    });
    // print("Status Code : ${response.data}");
    return AuthApiResponseModel.fromMap(response.data);
  }
}
