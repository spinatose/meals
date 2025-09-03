import 'package:flutter/material.dart';
import 'package:meals/domain/category.dart';
import 'package:meals/domain/meal.dart';
import 'package:meals/fixtures/dummy_data.dart';  
import 'package:meals/presentation/screen/meal_detail_screen.dart';
import 'package:meals/presentation/screen/meals_screen.dart';
import 'package:meals/presentation/widget/category_griditem.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  const CategoriesScreen({super.key, required this.onToggleFavorite, required this.availableMeals});

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: availableMeals
              .where((meal) => meal.categories.contains(category.id))
              .toList(),
          onSelectMeal: (context, meal) => _selectMeal(context, meal),
        ),
      ),
    );
  }

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MealDetailScreen(meal: meal, onToggleFavorite: onToggleFavorite)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: (context) => _selectCategory(context, category),
          ),
      ],
    );
  }
}
