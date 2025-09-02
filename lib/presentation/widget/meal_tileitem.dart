import 'package:flutter/material.dart';
import 'package:meals/domain/meal.dart';
import 'package:meals/presentation/widget/meal_itemtrait.dart';
import 'package:transparent_image/transparent_image.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

class MealTileItem extends StatelessWidget {
  final Meal meal;
  final void Function(BuildContext context) onSelectMeal;

  const MealTileItem({super.key, required this.meal, required this.onSelectMeal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: InkWell(
        onTap: () {
          onSelectMeal(context);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title, 
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(icon: Icons.schedule, label: "${meal.duration} min",),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.brunch_dining, label: meal.complexity.name.capitalize()),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.attach_money, label: meal.affordability.name.capitalize()),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
