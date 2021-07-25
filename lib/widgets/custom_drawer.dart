import 'package:e_shop_flutter_api/model/user_model.dart';
import 'package:e_shop_flutter_api/services/services.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final UserModel userModel;
  const CustomDrawer({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            // decoration: BoxDecoration(),
            accountEmail: Text(userModel.email),
            accountName: Text(userModel.name),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 34,
                backgroundImage: NetworkImage(
                  "https://wefutbolfans.com/wp-content/uploads/2020/07/Lionel-Messi-Leave-Barcelona.jpg",
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("Orders"),
            onTap: () async {
              await ApiService().getAllOrdersList();
              // final userModel = await AuthService().getUserDetails();
              // print(userModel.name);
            },
          ),
        ],
      ),
    );
  }
}
