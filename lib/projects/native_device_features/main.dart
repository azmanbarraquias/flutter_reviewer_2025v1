import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/screen/add_place_screen.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/screen/place_list_screen.dart';
import 'package:flutter_reviewer_2025v1/projects/native_device_features/providers/great_places.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Great Places",

        theme: ThemeData(
          primaryColor: Colors.indigo,
          hintColor: Colors.amber,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 4,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
        home: PlacesListScreen(),
      ),
    );
  }
}
