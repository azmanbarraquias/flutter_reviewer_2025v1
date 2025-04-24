import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price = 0,
    this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus() async {
    final oldFevStatus = isFavorite;
    const urlLink = 'myflutter-update-default-rtdb.firebaseio.com';
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    xPrint("toggleFavoriteStatus: $idToken");

    try {
      final url = Uri.https(urlLink, '/userFavorites/$uid/$id.json', {
        "auth": idToken,
      });

      isFavorite = !isFavorite;
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        _setFavValue(oldFevStatus);
        xPrint('${response.statusCode}');
        _setFavValue(oldFevStatus);
      }
      xPrint('toggleFavoriteStatus: ${json.decoder.convert(response.body)}');
      notifyListeners();
    } catch (error) {
      _setFavValue(oldFevStatus);
      xPrint('$error');
    }
  }
}
