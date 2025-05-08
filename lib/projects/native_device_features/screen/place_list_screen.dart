import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/providers/great_places.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/screen/place_detail_screen.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(
              context,
              listen: false,
            ).fetchAndSetPlaces(),

        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Consumer<GreatPlaces>(
            builder: (
              BuildContext context,
              GreatPlaces greatPlace,
              Widget? child,
            ) {
              if (greatPlace.items.isEmpty && child != null) {
                return child;
              } else {
                return ListView.builder(
                  itemCount: greatPlace.items.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PlaceDetailScreen.routeName,
                          arguments: greatPlace.items[index].id,
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlace.items[index].image,
                        ),
                      ),
                      title: Text(greatPlace.items[index].title),
                      subtitle: Text(greatPlace.items[index].location!.address),
                    );
                  },
                );
              }
            },
            child: Center(child: Text('No places added yet')),
          );
        },
      ),
    );
  }
}
