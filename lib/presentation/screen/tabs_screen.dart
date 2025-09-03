import 'package:flutter/material.dart';
import 'package:meals/domain/enums.dart';
import 'package:meals/domain/meal.dart';
import 'package:meals/fixtures/dummy_data.dart';
import 'package:meals/presentation/screen/categories_screen.dart';
import 'package:meals/presentation/screen/filters_screen.dart';
import 'package:meals/presentation/screen/meal_detail_screen.dart';
import 'package:meals/presentation/screen/meals_screen.dart';
import 'package:meals/presentation/widget/main_cajon.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
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
        MaterialPageRoute(builder: (context) => FiltersScreen(currentFilters: _selectedFilters)),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
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
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });

    _showInfoMessage(
      '${_favoriteMeals.contains(meal) ? 'Added to' : 'Removed from'} favorites!',
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      return (_selectedFilters[Filter.glutenFree] != true ||
              meal.isGlutenFree) &&
          (_selectedFilters[Filter.lactoseFree] != true ||
              meal.isLactoseFree) &&
          (_selectedFilters[Filter.vegan] != true || meal.isVegan) &&
          (_selectedFilters[Filter.vegetarian] != true || meal.isVegetarian);
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
        activePage = MealsScreen(
          meals: _favoriteMeals,
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
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        onTap: (index) {
          _selectPage(index);
        },
      ),
      drawer: MainCajon(onSelectOption: _selectOption),
    );
  }
}
