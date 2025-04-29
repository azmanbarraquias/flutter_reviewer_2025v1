import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/firebase_options.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/helper/custom_route.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/provider/auth.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'provider/cart.dart';
import 'provider/orders.dart';
import 'provider/products.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/products_details_screen.dart';
import 'screens/user_product_screen.dart';
import 'screens/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providersList = [
      ChangeNotifierProvider(create: (ctx) => Auth()),
      ChangeNotifierProxyProvider<Auth, Products>(
        create: (_) => Products(null, []),
        update:
            (ctx, auth, previous) => Products(
              auth.token, // assuming `token` is not null
              previous?.products ??
                  [], // safer null check with default fallback
            ),
      ),
      ChangeNotifierProvider(create: (ctx) => Cart()),

      ChangeNotifierProxyProvider<Auth, Orders>(
        create: (_) => Orders(null, []),
        update:
            (ctx, auth, previous) => Orders(
              auth.token, // assuming `token` is not null
              previous?.orders ?? [], // safer null check with default fallback
            ),
      ),
    ];

    final themeData = ThemeData(
      primarySwatch: Colors.blue,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          // TargetPlatform.iOS: CustomPageTransitionBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
        ),
      ),
    );

    final routeList = {
      ProductsOverviewScreen.routeName: (ctx) => const ProductsOverviewScreen(),
      ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
      CartScreen.routeName: (ctx) => const CartScreen(),
      OrdersScreen.routeName: (ctx) => const OrdersScreen(),
      UserProductScreen.routeName: (ctx) => const UserProductScreen(),
      EditProductScreen.routeName: (ctx) => const EditProductScreen(),
    };

    return MultiProvider(
      providers: providersList,
      child: Consumer<Auth>(
        builder: (_, auth, __) {
          return MaterialApp(
            scaffoldMessengerKey: scaffoldKey,
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            routes: routeList,
            theme: themeData,
            home:
                auth.isAuth
                    ? const ProductsOverviewScreen()
                    : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder:
                          (
                            BuildContext context,
                            AsyncSnapshot<bool> snapshot,
                          ) =>
                              snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                  : AuthScreen(),
                    ),
          );
        },
      ),
    );
  }
}
