import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            // decoration: BoxDecoration(),
            accountEmail: Text("ishworpanta10@gmail.com"),
            accountName: Text("Ishwor Panta"),
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
            title: Text("Oerders"),
          )
        ],
      ),
    );
  }
}
