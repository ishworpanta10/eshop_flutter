import 'package:e_shop_flutter_api/model/model.dart';
import 'package:e_shop_flutter_api/model/user_model.dart';
import 'package:e_shop_flutter_api/services/auth_service.dart';
import 'package:e_shop_flutter_api/services/services.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';
import 'package:e_shop_flutter_api/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final token = Constants.prefs!.getString(Constants.tokenSP);
    // print(token);
    return FutureBuilder<UserModel>(
      future: AuthService().getUserDetails(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            drawer: CustomDrawer(
              userModel: snapshot.data,
            ),
            appBar: AppBar(
              title: const Text('E Shop App'),
              actions: [
                IconButton(
                  onPressed: () {
                    Constants.prefs?.setBool(Constants.loginSP, false);
                    Constants.prefs?.setString(Constants.tokenSP, "");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.exit_to_app),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text("Welcome ${snapshot.data.name}"),
                ),
                Expanded(
                  child: FutureBuilder<List<ProductModel>>(
                    future: ApiService().getAllProductList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final ProductModel product = snapshot.data[index];
                            return ListTile(
                              leading: product.image!.isNotEmpty ? Image.network(product.image!) : Image.network("https://icon-library.com/images/photo-placeholder-icon/photo-placeholder-icon-14.jpg"),
                              title: Text(product.name),
                              subtitle: Text(product.description),
                              trailing: Text(
                                "Rs. ${product.price.toString()}",
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error_outline);
                      } else {
                        return Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(body: Center(child: Icon(Icons.error_outline)));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("E Shop App"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
