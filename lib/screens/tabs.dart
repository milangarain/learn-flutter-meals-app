import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

Map<Filters,bool> get defaultInitialFilters {
  final Map<Filters,bool> obj = {};
  for(final filter in Filters.values) {
    obj[filter] = false;
  }
  return obj;

}

final kInitialFilters = defaultInitialFilters;

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTabsIndex = 0;
  final List<Meal> fevouriteMeals = [];
  final Map<Filters,bool> filters = kInitialFilters;
  void _selectPage(int index) {
    setState(() {
      _selectedTabsIndex = index;
    });
  }

  // void _showMessage(String content) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(content)),
  //   );
  // }

  void _toggleFevouriteMeal(Meal meal) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (fevouriteMeals.contains(meal)) {
      setState(() {
        fevouriteMeals.remove(meal);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This is no longer a fevourite Meal.")),
      );
    } else {
      setState(() {
        fevouriteMeals.add(meal);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This is added to fevourite meal list.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        CategoriesScreen(onToggleFevouriteMeal: _toggleFevouriteMeal, mealFilters:filters);
    String screenTitle = "Categories Screen";
    if (_selectedTabsIndex == 1) {
      content = MealsScreen(
          meals: fevouriteMeals, onToggleFevouriteMeal: _toggleFevouriteMeal);
      screenTitle = "Your Fevourites";
      //currentIndex = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      drawer: MainDrawer(filters),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedTabsIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "favourites",
          ),
        ],
      ),
    );
  }
}
