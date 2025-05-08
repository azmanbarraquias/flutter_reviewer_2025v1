import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      lat: 37.42796133580664,
      lng: -122.085749655962,
      address: '',
    ),
    this.isSelecting = false,
  });

  final PlaceLocation initialLocation;
  final bool isSelecting;

  static const routeName = '/map';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your Location' : 'Your Location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed:
                  _pickedLocation == null
                      ? null
                      : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
              icon: Icon(Icons.add),
            ),
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          markers:
              (_pickedLocation == null && widget.isSelecting)
                  ? {}
                  : {
                    Marker(
                      markerId: MarkerId('m1'),
                      position:
                          _pickedLocation ??
                          LatLng(
                            widget.initialLocation.lat,
                            widget.initialLocation.lng,
                          ), // assuming _pickedLocation is a LatLng
                    ),
                  },
          onTap: widget.isSelecting ? _selectLocation : null,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(
              widget.initialLocation.lat,
              widget.initialLocation.lng,
            ),
          ),
        ),
      ),
    );
  }
}
