import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/fixtures/dummy_data.dart';
import 'package:meals/domain/meal.dart';

final mealsProvider = FutureProvider<List<Meal>>((ref) async {
  // Simulate async loading (in a real app, this would be an API call)
  await Future.delayed(const Duration(milliseconds: 500));
  return dummyMeals;
});