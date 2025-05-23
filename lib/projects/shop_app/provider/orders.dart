import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/provider/product.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';

import '../models/cart_product.dart';
import '../models/order.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  Orders(this.authToken, this._orders);

  List<Order> _orders = [];

  final String? authToken;

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    final uid = FirebaseAuth.instance.currentUser?.uid;

    try {
      final url = Uri.https(urlLink, '/orders/$uid.json', {"auth": idToken});

      final response = await http.get(url);
      final extractedData = json.decoder.convert(response.body);
      xPrint(extractedData);
      final List<Order> loadedOrders = [];
      final products = extractedData as Map<String, dynamic>?;
      if (products == null) {
        return;
      }
      products.forEach((orderId, orderData) {
        loadedOrders.add(
          Order(
            id: orderId,
            amount: double.tryParse(orderData['amount'].toString()) ?? 0,
            dateTime: DateTime.parse(orderData['dateTime']),
            products:
                (orderData['products'] as List<dynamic>)
                    .map(
                      (cardProd) => CartProduct(
                        id: cardProd['id'],
                        quantity: cardProd['quantity'],
                        product: Product(
                          id: cardProd['id'],
                          title: cardProd['title'],
                          price: cardProd['price'],
                        ),
                      ),
                    )
                    .toList(),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      xPrint('fetchAndSetOrder error: $error');
      rethrow;
    }
  }

  Future<void> addOrder(List<CartProduct> cartProduct, double total) async {
    if (cartProduct.isEmpty) return;

    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      final url = Uri.https(urlLink, 'orders/$uid.json', {"auth": idToken});
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': DateTime.now().toIso8601String(),
          'products':
              cartProduct
                  .map(
                    (cartProduct) => {
                      'id': cartProduct.product.id,
                      'title': cartProduct.product.title,
                      'quantity': cartProduct.quantity,
                      'price': cartProduct.product.price,
                    },
                  )
                  .toList(),
        }),
      );
      xPrint('addOrder ${json.decoder.convert(response.body)['name']}');
      await Future.delayed(const Duration(seconds: 3));

      _orders.insert(
        0,
        Order(
          id: json.decoder.convert(response.body)['name'],
          amount: total,
          products: cartProduct,
          dateTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (error) {
      xPrint(error);
    }
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}
