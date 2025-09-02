import 'package:flutter/material.dart';
import 'package:meals/domain/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;
  
  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(
        children: [
          Image.network(meal.imageUrl),
          const SizedBox(height: 16),
          Text(meal.ingredients.join(', '), style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),),
          const SizedBox(height: 16),
          Text(meal.steps.join('\n'), style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),),
        ],
      ),
    );
  }
}
