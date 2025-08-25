import 'package:flutter/material.dart';
import 'package:meals/domain/category.dart';
import 'package:meals/domain/meal.dart';
class MealsScreen extends StatelessWidget {
  final Category category;
  final List<Meal> meals;
  
  const MealsScreen({super.key, required this.category, required this.meals});

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Uh oh... nothing here!', style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),), 
              SizedBox(height: 16),
              Text('Try selecting a different category!', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return Text(meals[index].title);
        },
      ),
    );
  }
}