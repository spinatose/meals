import 'package:flutter/material.dart';
import 'package:meals/domain/enums.dart';
import 'package:meals/presentation/widget/filter_switch_tile.dart';

class FiltersScreen extends StatefulWidget {
  final Map<Filter, bool> currentFilters;
  const FiltersScreen({super.key, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late var _glutenFreeSet = widget.currentFilters[Filter.glutenFree] ?? false;
  late var _lactoseFreeSet = widget.currentFilters[Filter.lactoseFree] ?? false;
  late var _veganSet = widget.currentFilters[Filter.vegan] ?? false;
  late var _vegetarianSet = widget.currentFilters[Filter.vegetarian] ?? false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Filters')),
      // drawer: MainCajon(
      //   onSelectOption: (option) {
      //     Navigator.of(context).pop();

      //     if (option == CajonOption.meals) {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => TabsScreen()),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return ;

          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeSet,
            Filter.lactoseFree: _lactoseFreeSet,
            Filter.vegan: _veganSet,
            Filter.vegetarian: _vegetarianSet,
          });
        },
        child: Column(
          children: [
            FilterSwitchTile(
              value: _glutenFreeSet,
              onChanged: (isChecked) =>
                  setState(() => _glutenFreeSet = isChecked),
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
            ),
            FilterSwitchTile(
              value: _lactoseFreeSet,
              onChanged: (isChecked) =>
                  setState(() => _lactoseFreeSet = isChecked),
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
            ),
            FilterSwitchTile(
              value: _veganSet,
              onChanged: (isChecked) => setState(() => _veganSet = isChecked),
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
            ),
            FilterSwitchTile(
              value: _vegetarianSet,
              onChanged: (isChecked) =>
                  setState(() => _vegetarianSet = isChecked),
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
            ),
          ],
        ),
      ),
    );
  }
}
