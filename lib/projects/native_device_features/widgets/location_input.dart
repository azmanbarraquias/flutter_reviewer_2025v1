import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../utils/xprint.dart';
import '../helpers/location_helper.dart';
import '../screen/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.selectPlace});

  final Function selectPlace;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      widget.selectPlace(locationData.latitude, locationData.longitude);
      if (locationData.latitude == null || locationData.longitude == null) {
        return;
      }
      _showPreview(locationData.latitude!, locationData.longitude!);
      xPrint(locationData);
    } catch (error) {
      xPrint(error);
      return;
    }
  }

  void _showPreview(double lat, double long) {
    final staticMapImageURL = LocationHelper.generateLocationPreviewImage(
      lat: lat,
      long: long,
    );
    setState(() {
      _previewImageURL = staticMapImageURL;
      xPrint(_previewImageURL);
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(isSelecting: true),
      ),
    );

    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);

    setState(() {
      _previewImageURL = LocationHelper.generateLocationPreviewImage(
        lat: selectedLocation.latitude,
        long: selectedLocation.longitude,
      );
      xPrint(_previewImageURL);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child:
              _previewImageURL == null
                  ? Text('No location chosen')
                  : Image.network(_previewImageURL!, fit: BoxFit.cover),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
