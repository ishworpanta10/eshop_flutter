import 'package:bot_toast/bot_toast.dart';
import 'package:e_shop_flutter_api/model/auth/auth_api_response_model.dart';
import 'package:e_shop_flutter_api/screen/login.dart';
import 'package:e_shop_flutter_api/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _phoneValidation(String value) {
    // final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    final numericRegex = RegExp(r'^\+?(?:977)?[ -]?(?:(?:(?:98|97)-?\d{8})|(?:01-?\d{7}))$');
    return numericRegex.hasMatch(value);
  }

  bool _emailValidation(String value) {
    final emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailRegex.hasMatch(value);
  }

  bool _passwordValidate(String value) {
    bool isValid = false;
    if (value.isEmpty) {
      isValid = false;
    } else if (value.length < 6) {
      isValid = false;
    } else if (value.length > 50) {
      isValid = false;
    } else {
      isValid = true;
    }
    return isValid;
  }

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
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'name',
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "name can not be empty" : null;
                  },
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'phone',
                  ),
                  validator: (value) {
                    bool isValid = _phoneValidation(value!);
                    return isValid ? null : "invalid phone";
                  },
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                  validator: (value) {
                    bool isValid = _emailValidation(value!);
                    return isValid ? null : "invalid email";
                  },
                ),
                const SizedBox(height: 6),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                  ),
                  validator: (value) {
                    bool isValid = _passwordValidate(value!);
                    return isValid ? null : "password must be more than 6";
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
                      Navigator.pop(context);
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
      final name = _nameController.text;
      final phone = _phoneController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      print("Name : $name");
      print("Phone : $phone");
      print("Email : $email");
      print("Password : $password");
      final AuthApiResponseModel data = await AuthService().registerWithEmailAndPasswordAndGetToken(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      final responseEmail = data.email;
      if (responseEmail != null) {
        BotToast.showText(text: "Success : ${data.message}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginPage(),
          ),
        );
      } else {
        BotToast.showText(text: "Failed: ${data.message}");
      }
      BotToast.closeAllLoading();
      //  clear all editing controller
    }
  }
}
