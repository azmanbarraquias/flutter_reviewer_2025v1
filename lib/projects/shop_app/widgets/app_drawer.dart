import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/screens/products_overview_screen.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';

import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          AppBar(
            title: const Text('APP Drawer'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              var name = ModalRoute.of(context)?.settings.name;
              xPrint('Open $name');
              if (name == ProductsOverviewScreen.routeName || name == null) {
                Navigator.of(context).pop();
                return;
              }

              Navigator.of(
                context,
              ).pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name == '/orders') {
                xPrint('Same Page');
                Navigator.of(context).pop();
                return;
              }
              Navigator.of(
                context,
              ).pushReplacementNamed(OrdersScreen.routeName);
              xPrint('Open ${ModalRoute.of(context)?.settings.name}');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductScreen.routeName);
              xPrint('Open ${ModalRoute.of(context)?.settings.name}');
            },
          ),
        ],
      ),
    );
  }
}
