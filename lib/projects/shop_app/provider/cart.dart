import 'package:flutter/foundation.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';

import '../models/cart_product.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  final Map<String, CartProduct> _items = {};

  Map<String, CartProduct> get items => {..._items};

  get total => _items.values.reduce((sum, element) => sum.total + element);

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (value) => CartProduct(
          id: value.id,
          product: value.product,
          quantity: value.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartProduct(
          id: DateTime.now().toString(),
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  bool containInCart(Product product) {
    return _items.containsKey(product.id);
  }

  void removeItem(CartProduct cartProduct) {
    xPrint('card product removed: ${cartProduct.product.title}');
    _items.remove(cartProduct.product.id);
    notifyListeners();
  }

  void removeSingleItem(String? productID) {
    if (!_items.containsKey(productID)) {
      return;
    }

    // remove -1 is quantity is more than 1 else remove.
    if (_items[productID]!.quantity > 1) {
      _items.update(
        productID!,
        (product) => CartProduct(
          id: product.id,
          product: product.product,
          quantity: product.quantity - 1,
        ),
      );
    } else {
      _items.remove(productID);
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.product.price! * cartItem.quantity;
    });

    return total;
  }
}
