import 'package:bot_toast/bot_toast.dart';
import 'package:e_shop_flutter_api/model/user_model.dart';
import 'package:e_shop_flutter_api/screen/homepage.dart';
import 'package:e_shop_flutter_api/screen/login.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'E Shop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Constants.prefs?.getBool(Constants.loginSP) == true
          ? HomePage(
              userModel: UserModel(
                id: "60b70ad0999c4d2088cc5be6",
                name: "Ishwor Panta IP",
                email: "ishworpanta10@gmail.com",
                phone: 985435667,
              ),
            )
          : LoginPage(),
    );
  }
}
