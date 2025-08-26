import 'package:flutter/material.dart';
import 'package:meals/domain/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function(BuildContext context) onSelectCategory;

  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelectCategory(context);
      },
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
