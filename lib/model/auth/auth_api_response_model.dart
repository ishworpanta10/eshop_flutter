import 'package:e_shop_flutter_api/model/user_model.dart';

class AuthApiResponseModel {
  String message;
  String? email;
  String? token;
  UserModel? userModel;

  AuthApiResponseModel({this.email, required this.message, this.token, this.userModel});

  factory AuthApiResponseModel.fromMap(Map<String, dynamic> json) {
    return AuthApiResponseModel(
      message: json["message"],
      email: json["email"],
      token: json["token"],
      userModel: json["user"] != null ? UserModel.fromMap(json["user"]) : null,
    );
  }
}
