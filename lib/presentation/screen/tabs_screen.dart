import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/domain/enums.dart';
import 'package:meals/domain/meal.dart';
import 'package:meals/presentation/screen/categories_screen.dart';
import 'package:meals/presentation/screen/filters_screen.dart';
import 'package:meals/presentation/screen/meal_detail_screen.dart';
import 'package:meals/presentation/screen/meals_screen.dart';
import 'package:meals/presentation/widget/main_cajon.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/meals_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meal,
          onToggleFavorite: _toggleMealFavoriteStatus,
        ),
      ),
    );
  }

  void _selectOption(CajonOption option) async {
    Navigator.of(context).pop();

    if (option == CajonOption.filters) {
      var result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else if (option == CajonOption.meals) {
      setState(() {
        _selectedPageIndex = 0; // Switch to Categories tab
      });
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final wasFavorite = ref.read(favoritesProvider).contains(meal);
    ref.read(favoritesProvider.notifier).toggleFavoriteStatus(meal);

    _showInfoMessage(
      '${wasFavorite ? 'Removed from' : 'Added to'} favorites!',
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealsAsync = ref.watch(mealsProvider);


    return mealsAsync.when(
      data: (meals) {
        final availableMeals = meals.where((meal) {
          return (_selectedFilters[Filter.glutenFree] != true ||
                  meal.isGlutenFree) &&
              (_selectedFilters[Filter.lactoseFree] != true ||
                  meal.isLactoseFree) &&
              (_selectedFilters[Filter.vegan] != true || meal.isVegan) &&
              (_selectedFilters[Filter.vegetarian] != true ||
                  meal.isVegetarian);
        }).toList();

        Widget activePage = CategoriesScreen(
          onToggleFavorite: _toggleMealFavoriteStatus,
          availableMeals: availableMeals,
        );
        String activePageTitle = 'Categories';

        switch (_selectedPageIndex) {
          case 0:
            activePage = CategoriesScreen(
              onToggleFavorite: _toggleMealFavoriteStatus,
              availableMeals: availableMeals,
            );
            activePageTitle = 'Categories';
            break;
          case 1:
            final favorites = ref.watch(favoritesProvider);
            activePage = MealsScreen(
              title: null,
              meals: favorites,
              onSelectMeal: (context, meal) => _selectMeal(context, meal),
            );
            activePageTitle = 'Favorites';
            break;
        }

        return Scaffold(
          appBar: AppBar(title: Text(activePageTitle)),
          body: activePage,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.set_meal),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
            ],
            onTap: (index) {
              _selectPage(index);
            },
          ),
          drawer: MainCajon(onSelectOption: _selectOption),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }
}
