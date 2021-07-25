class AuthApiResponseModel {
  String message;
  String? email;
  String? token;

  AuthApiResponseModel({this.email, required this.message, this.token});

  factory AuthApiResponseModel.fromMap(Map<String, dynamic> json) {
    return AuthApiResponseModel(
      message: json["message"],
      email: json["email"],
      token: json["token"],
    );
  }
}
