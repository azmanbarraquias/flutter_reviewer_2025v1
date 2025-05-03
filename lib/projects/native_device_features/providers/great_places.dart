import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace({required String title, required File pickedImage}) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      table: 'user_places',
      data: {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData(table: 'user_places');
    final dataList =
        data
            .map(
              (item) => Place(
                id: item['id'],
                title: item['title'],
                image: File(item['image']),
                location: null,
              ),
            )
            .toList();
    _items.clear();
    _items.addAll(dataList);

    // add 2 second delay
    await Future.delayed(Duration(seconds: 2));

    notifyListeners();
  }
}
