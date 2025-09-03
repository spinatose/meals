import 'package:flutter/material.dart';
import 'package:meals/domain/meal.dart';
import 'package:meals/presentation/widget/meal_tileitem.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onSelectMeal,
  });

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Uh oh... nothing here!',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Try selecting a different category!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (title == null) {
      return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealTileItem(
            meal: meals[index],
            onSelectMeal: (context) => onSelectMeal(context, meals[index]),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealTileItem(
            meal: meals[index],
            onSelectMeal: (context) => onSelectMeal(context, meals[index]),
          );
        },
      ),
    );
  }
}
