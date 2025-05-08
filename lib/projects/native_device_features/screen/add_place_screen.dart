import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';
import '../models/place.dart';
import '../providers/great_places.dart';
import '../widgets/image_input.dart';
import 'package:provider/provider.dart';

import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _placeLocation;

  void _selectImage(File pickedImage) {
    xPrint('_selectImage');
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _placeLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).addPlace(title: _titleController.text, pickedImage: _pickedImage!, location: _placeLocation!);
    Navigator.of(context).pop();
    xPrint('_savePlace');
  }

  void _selectPlace(double lat, double long) {
    _placeLocation = PlaceLocation(lat: lat, lng: long, address: '');
    xPrint('_selectPlace');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a New Place')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(height: 10),
                    Container(),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(height: 10),
                    LocationInput(selectPlace: _selectPlace),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: _savePlace,
              label: Text('Add Place', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Colors.white.withValues(alpha: 0.12);
                  }
                  return null;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
