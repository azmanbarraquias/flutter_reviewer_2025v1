import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final selectedPlace = Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text('Place Detail')),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location!.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location!.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) {
                    return MapScreen(initialLocation: selectedPlace.location!);
                  },
                ),
              );
            },
            child: Text('View on Map'),
          ),
        ],
      ),
    );
  }
}
