import 'package:bot_toast/bot_toast.dart';
import 'package:e_shop_flutter_api/model/auth/login_api_response_model.dart';
import 'package:e_shop_flutter_api/screen/login.dart';
import 'package:e_shop_flutter_api/services/auth_service.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class RegisterPage extends StatelessWidget {
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REGISTER',
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
                    return value!.isEmpty ? "email can bot be empty" : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "password can bot be empty" : null;
                  },
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      _handleRegister(context);
                    },
                    child: Text('Register'),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(),
                        ),
                      );
                    },
                    child: Text("Already have account ? Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      BotToast.showLoading();
      final email = _emailController.text;
      final password = _passwordController.text;
      print("Email : $email , Password : $password");
      final AuthApiResponseModel data = await AuthService().registerWithEmailAndPasswordAndGetToken(
        email: email,
        password: password,
      );
      print("Token : ${data.token}");
      final token = data.token;
      if (token != null) {
        Constants.prefs?.setString(Constants.tokenSP, token);
        Constants.prefs?.setBool(Constants.loginSP, true);
        BotToast.showText(text: "Login Success ${data.message}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      } else {
        BotToast.showText(text: "Login Failed ${data.message}");
      }
      BotToast.closeAllLoading();
    }
  }
}
