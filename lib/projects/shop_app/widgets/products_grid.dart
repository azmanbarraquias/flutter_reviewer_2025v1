import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../provider/product.dart';
import '../provider/products.dart';
import 'product_item.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key,
    required this.showFavorite,
    required this.filterType});

  final bool showFavorite;
  final FilterOptions filterType;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {

  List<Product> productList (FilterOptions type) {
    final Products proProvider = Provider.of<Products>(context, listen: true);
    final cart = Provider.of<Cart>(context, listen: true);
    switch (type) {
      case FilterOptions.all:
        return proProvider.products;
      case FilterOptions.favorite:
        return proProvider.products.where((product) => product.isFavorite).toList();
      case FilterOptions.cart:
        return proProvider.products.where((product) => cart.containInCart(product)).toList();
      default:
        return proProvider.products;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Products proProvider = Provider.of<Products>(context,
        listen: true); // refresh if product added new item.
    // final List<Product> products = widget.showFavorite ? proProvider.products.where((product) => product.isFavorite).toList() : proProvider.products;
        // widget.showFavorite ? proProvider.favoritesItems : proProvider.products;
    final List<Product> products =  productList(widget.filterType);

    return RefreshIndicator(
      onRefresh: () => proProvider.fetchAndSetProducts(),
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.only(top: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(key: ValueKey(products[i].id)),
          );
        },
      ),
    );
  }
}
