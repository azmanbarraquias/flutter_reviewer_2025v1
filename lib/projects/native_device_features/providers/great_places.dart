import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/helpers/db_helper.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/helpers/location_helper.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace({
    required String title,
    required File pickedImage,
    required PlaceLocation location,
  }) async {
    final address = await LocationHelper.getPlaceAddress(
      location.lat,
      location.lng,
    );
    final updatedLocation = PlaceLocation(
      lat: location.lat,
      lng: location.lng,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: pickedImage,
      location: updatedLocation,
    );
    xPrint(newPlace);
    _items.add(newPlace);
    notifyListeners();
    xPrint(newPlace);
    DBHelper.insert(
      table: 'user_places',
      data: {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location!.lat,
        'loc_lng': newPlace.location!.lng,
        'address': newPlace.location!.address,
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
                location: PlaceLocation(
                  lat: item['loc_lat'],
                  lng: item['loc_lng'],
                  address: item['address'],
                ),
              ),
            )
            .toList();
    xPrint('List of place $dataList');

    _items.clear();
    _items.addAll(dataList);

    // add 2 second delay
    await Future.delayed(Duration(seconds: 2));

    notifyListeners();
  }
}
