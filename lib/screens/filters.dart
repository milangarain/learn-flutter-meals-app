import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

const Map<Filters, String> filterTextName = {
  Filters.glutenFree: 'Gluten-free',
  Filters.lactoseFree: 'Lactose-free',
  Filters.vegetarian: 'Vegetarian',
  Filters.vegan: 'Vegan',
};

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this.filters, {super.key});
  final Map<Filters, bool> filters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<SwitchListTile> getFilterTiles() {
    return Filters.values.map((filter) {
      return SwitchListTile(
        value: widget.filters[filter]!,
        onChanged: (isChecked) {
          setState(() {
            widget.filters[filter] = isChecked;
          });
        },
        title: Text(
          filterTextName[filter]!,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        subtitle: Text(
          'Only include ${filterTextName[filter]!.toLowerCase()} meals.',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        activeColor: Theme.of(context).colorScheme.tertiary,
        contentPadding: const EdgeInsets.only(left: 34, right: 22),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Filter Meals")),
      body: Column(children: getFilterTiles()),
    );
  }
}
