import 'package:bot_toast/bot_toast.dart';
import 'package:e_shop_flutter_api/model/auth/auth_api_response_model.dart';
import 'package:e_shop_flutter_api/model/user_model.dart';
import 'package:e_shop_flutter_api/screen/register.dart';
import 'package:e_shop_flutter_api/services/auth_service.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "email can not be empty" : null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "password can not be empty" : null;
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      _handleLogin(context);
                    },
                    child: Text('Login'),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text("Don't have account ? Register"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      BotToast.showLoading();
      final email = _emailController.text;
      final password = _passwordController.text;
      print("Email : $email , Password : $password");
      final AuthApiResponseModel data = await AuthService().loginWithCredAndGetToken(
        email: email,
        password: password,
      );
      print("Token : ${data.token}");
      final token = data.token;
      if (token != null) {
        Constants.prefs?.setString(Constants.tokenSP, token);
        Constants.prefs?.setBool(Constants.loginSP, true);
        BotToast.showText(text: "Success ${data.message}");
        final UserModel userModel = UserModel(
          id: data.userModel!.id,
          name: data.userModel!.name,
          email: data.userModel!.email,
          phone: data.userModel!.phone,
          image: data.userModel!.image,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(userModel: userModel),
          ),
        );
      } else {
        BotToast.showText(text: "Failed : ${data.message}");
      }
      BotToast.closeAllLoading();
    }
  }
}
