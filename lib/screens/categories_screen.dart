import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFevouriteMeal,
    required this.mealFilters,
  });
  final Map<Filters, bool> mealFilters;
  final void Function(Meal meal) onToggleFevouriteMeal;

  void _selectCategory(BuildContext context, Category selectedCategory) {
    // final selectedCategoryId = availableCategories.firstWhere((category) => category.title == 'Hamburgers').id;
    //final availableMeals = dummyMeals.where()
    final List<Meal> categoryMeals = dummyMeals.where((meal) {
      return meal.categories.contains(selectedCategory.id) &&
          (!mealFilters[Filters.glutenFree]! || meal.isGlutenFree) &&
          (!mealFilters[Filters.lactoseFree]! || meal.isLactoseFree) &&
          (!mealFilters[Filters.vegetarian]! || meal.isVegetarian) &&
          (!mealFilters[Filters.vegan]! || meal.isVegan);
    }).toList();
    final route = MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: selectedCategory.title,
        meals: categoryMeals,
        onToggleFevouriteMeal: onToggleFevouriteMeal,
      ),
    );
    // Navigator.push(context, route);
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategory(context, category),
          )
      ],
      //availableCategories.map((category) =>CategoryGridItem(category: category)).toList(),
    );
  }
}
