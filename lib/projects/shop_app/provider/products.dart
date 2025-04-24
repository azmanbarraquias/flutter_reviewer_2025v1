import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/models/http_exception.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product.dart';

class Products with ChangeNotifier {
  Products(this.authToken, this._products);

  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String? authToken;

  List<Product> get products {
    // return a copy
    return [..._products];
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    _products = [];

    const urlBase = 'myflutter-update-default-rtdb.firebaseio.com';
    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdToken();
    final uid = user?.uid;

    final queryParams =
        filterByUser
            ? {
              "auth": idToken,
              "orderBy": "\"creatorID\"",
              "equalTo": "\"$uid\"",
            }
            : {"auth": idToken};

    final productsUrl = Uri.https(urlBase, '/products.json', queryParams);
    final favoritesUrl = Uri.https(urlBase, '/userFavorites/$uid.json', {
      "auth": idToken,
    });

    try {
      xPrint("fetchAndSetProducts idToken: $idToken");

      final productsResponse = await http.get(productsUrl);
      final favoritesResponse = await http.get(favoritesUrl);

      xPrint("Products response: ${productsResponse.body}");

      final productData = json.decode(productsResponse.body);
      final favoritesData = json.decode(favoritesResponse.body);

      final List<Product> loadedProducts = [];

      productData?.forEach((id, data) {
        loadedProducts.add(
          Product(
            id: id,
            title: data['title'],
            description: data['description'],
            price: double.tryParse(data['price'].toString()),
            imageUrl: data['imageUrl'],
            isFavorite: favoritesData?[id] ?? false,
          ),
        );
      });

      _products = loadedProducts;

      xPrint('Final products list: $_products');
    } catch (error) {
      xPrint("Error fetching products: $error");
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';

    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    xPrint("addProduct idToken: $idToken");
    final url = Uri.https(urlLink, '/products.json', {"auth": authToken});

    try {
      final response = await http.post(
        url,
        body: json.encoder.convert({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorID': uid,
          // 'isFavorite': product.isFavorite,
        }),
      );

      final responseFromServer = json.decoder.convert(response.body)['error'];

      if (responseFromServer == 'Permission denied') {
        throw Exception('Permission denied');
      }

      final idProduct = Product(
        id: json.decoder.convert(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      // put 2 sec delay, loading.
      await Future.delayed(Duration(seconds: 2));

      _products.add((idProduct));

      notifyListeners();

      xPrint('Response Message: $responseFromServer');
    } catch (error) {
      xPrint('error> $error, at addProduct()');
      rethrow;
    }
  }

  Future<void> addProductOther(Product product) async {
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    xPrint("addProduct idToken: $idToken");
    final url = Uri.https(urlLink, '/products.json', {"auth": authToken});

    await http
        .post(
          url,
          body: json.encoder.convert({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            // 'isFavorite': product.isFavorite,
          }),
        )
        .then((response) {
          // since post is a future function we can use then.

          var idProduct = Product(
            id: json.decoder.convert(response.body)['name'],
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
          );

          _products.add((idProduct));

          notifyListeners();

          xPrint('Response: ${json.decoder.convert(response.body)}');
        })
        .catchError((error) {
          xPrint('error> $error, at addProduct()');
          throw error;
        });
  }

  // bool _showFavorites = false;
  //
  // bool get isFev {
  //   return _showFavorites;
  // }
  //
  // void showFev() {
  //   _showFavorites = true;
  //   notifyListeners();
  //,
  // }
  //
  // void showAll() {
  //   _showFavorites = false;
  //   notifyListeners();
  //
  // }

  Product findByProduct(Product product) {
    return products.firstWhere((productProv) => productProv.id == product.id);
  }

  // dart don't have overloading
  Product findById(String productID) {
    return products.firstWhere((productProv) => productProv.id == productID);
  }

  Future<void> updateProduct(Product productUpdate) async {
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';

    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    xPrint("updateProduct idToken: $idToken");

    final prodIndex = products.indexWhere(
      (product) => product.id == productUpdate.id,
    );
    try {
      if (prodIndex >= 0) {
        final url = Uri.https(urlLink, '/products/${productUpdate.id}.json', {
          "auth": idToken,
        });

        final response = await http.patch(
          url,
          body: json.encoder.convert({
            'title': productUpdate.title,
            'description': productUpdate.description,
            'imageUrl': productUpdate.imageUrl,
            'price': productUpdate.price,
            // 'isFavorite': productUpdate.isFavorite,
          }),
        );
        _products[prodIndex] = productUpdate;

        final responseFromServer = json.decoder.convert(response.body);
        xPrint('updateProduct $responseFromServer');

        notifyListeners();
        // fetchAndSetProducts();
      }
    } catch (error) {
      xPrint(error);
      rethrow;
    }
  }

  Future<void> deleteProduct(Product productUpdate) async {
    // 200, 201, 300, 400, 500
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';
    final url = Uri.https(urlLink, '/products/${productUpdate.id}.json');

    final index = products.indexWhere(
      (product) => product.id == productUpdate.id,
    );
    Product? tempProduct = products[index];
    _products.removeAt(index);
    notifyListeners();
    try {
      final response = await http.delete(url);
      xPrint('deleteProduct statusCode: ${response.statusCode}');
      if (response.statusCode >= 400) {
        throw HttpException(response.body);
      }
      xPrint('deleteProduct ${tempProduct.title} has been deleted');
      tempProduct = null;
    } catch (error) {
      _products.insert(index, tempProduct!);
      notifyListeners();
      throw HttpException(error.toString());
      // rethrow;
      // rethrow;
    }
  }

  Future<void> deleteProduct1(Product productUpdate) async {
    // 200, 201, 300, 400, 500
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';
    final url = Uri.https(urlLink, '/products/${productUpdate.id}.json');

    final index = products.indexWhere(
      (product) => product.id == productUpdate.id,
    );
    Product? tempProduct = products[index];

    var test = await http
        .delete(url)
        .then((m) {
          if (m.statusCode >= 400) {
            xPrint('deleteProduct error: ${m.statusCode}');
          }

          xPrint('deleteProduct ${tempProduct?.title} has been deleted');
          tempProduct = null;
        })
        .catchError((error) {
          xPrint('deleteProduct error: $error');
          _products.insert(index, tempProduct!);
          notifyListeners();
        });
    xPrint('deleteProduct $test');
    _products.removeAt(index);
    notifyListeners();
  }

  List<Product> get favoritesItems {
    // if (_showFavorites) {
    return _products.where((product) => product.isFavorite).toList();
    // } else {
    //   return products;
    // }
  }
}
