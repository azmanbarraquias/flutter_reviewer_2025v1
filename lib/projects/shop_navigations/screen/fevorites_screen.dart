import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_navigations/models/meal_model.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_navigations/widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return const Center(child: Text('You have no favorites yet. . .'));
    } else {
      return ListView.builder(
        itemCount: widget.favoriteMeals.length,
        itemBuilder: (ctx, index) {
          var currentMeal = widget.favoriteMeals[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MealItem(meal: currentMeal, removeItem: () {}),
          );
        },
      );
    }
  }
}
