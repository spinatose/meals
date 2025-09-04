import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/domain/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  // Add or remove a meal from the favorites list
  // Can't modify underlying list, so we create a new list
  void toggleFavoriteStatus(Meal meal) {
    state = state.contains(meal) ? state.where((m) => m.id != meal.id).toList() : [...state, meal];
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
  return FavoritesNotifier();
});