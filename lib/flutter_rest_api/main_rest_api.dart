import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/flutter_rest_api/views/home_page_simple.dart';
import 'package:flutter_reviewer_2025v1/flutter_rest_api/views/home_page_yugioh.dart';
import 'package:flutter_reviewer_2025v1/utils/utils.dart';
import 'package:gap/gap.dart';

import 'views/home_page_pokemon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyPageMenu());
  }
}

class MyPageMenu extends StatelessWidget {
  const MyPageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RestAPI Sample',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Gap(10),
            navigateButton(
              context,
              title: 'JSONPlaceholder',
              page: () => HomePageSimple(),
            ),
            Gap(10),
            navigateButton(
              context,
              title: 'YGOPRODeck',
              page: () => HomePageYugiOh(),
            ),
            Gap(10),
            navigateButton(
              context,
              title: 'PokéAPI',
              page: () => HomePagePokemon(),
            ),
          ],
        ),
      ),
    );
  }

  navigateButton(context, {required String title, required Function() page}) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => page()));
      },
      child: Text(title, style: TextStyle(color: Utils.getRandomColor())),
    );
  }
}
