import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../utils/xprint.dart';
import '../../real_apps_practice/main.dart';
import '../provider/products.dart';
import '../widgets/user_product_item.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {

   UserProductScreen({super.key}){
    logWithLocation("UserProductScreen");
  }

  static const routeName = 'user-products';

  Future<void> _refreshProduct(BuildContext context) async {
    // trigger only. listen: false
    Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // bad trigger infinite build, use consumer, if we have new product
    // final products = Provider.of<Products>(context, listen: true);
    xPrint('UserProductScreen rebuild. . . ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
          IconButton(
            onPressed: () => _refreshProduct(context),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder:
            (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                      onRefresh: () => _refreshProduct(context),
                      child: Consumer<Products>(
                        builder: (
                          BuildContext _,
                          Products productData,
                          Widget? __,
                        ) {
                          return ListView.builder(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            itemCount: productData.products.length,
                            itemBuilder: (ctx, i) {
                              return Column(
                                children: [
                                  UserProductItem(
                                    product: productData.products[i],
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
      ),
    );
  }
}
