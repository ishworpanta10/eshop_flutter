import 'package:dio/dio.dart';
import 'package:e_shop_flutter_api/model/auth/auth_api_response_model.dart';
import 'package:e_shop_flutter_api/model/user_model.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';

class AuthService {
  final userModelUrl = "https://ishwor-node-eshop-test-api.herokuapp.com/api/v1/users/";
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

  Future<UserModel> getUserDetails() async {
    final token = Constants.prefs!.getString(Constants.tokenSP);
    final uid = Constants.prefs!.getString(Constants.userIdSP);
    print("Token in User Detail Service : $token");
    print("Id in Service : $uid");
    dio.options.headers["Authorization"] = "Bearer $token";
    var response = await dio.get("$userModelUrl$uid");
    // print("User Deatils ${response.data} ");
    return UserModel.fromMap(response.data);
  }
}
