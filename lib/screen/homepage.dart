import 'package:e_shop_flutter_api/model/model.dart';
import 'package:e_shop_flutter_api/model/user_model.dart';
import 'package:e_shop_flutter_api/services/services.dart';
import 'package:e_shop_flutter_api/utils/constants.dart';
import 'package:e_shop_flutter_api/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomePage extends StatelessWidget {
  final UserModel userModel;
  const HomePage({Key? key, required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final token = Constants.prefs!.getString(Constants.tokenSP);
    // print(token);
    return Scaffold(
      drawer: CustomDrawer(),
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
        children: [
          Text("Welcome ${userModel.name}"),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
