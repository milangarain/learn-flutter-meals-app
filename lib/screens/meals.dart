import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals,required this.onToggleFevouriteMeal, });
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFevouriteMeal;
  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Oops.... No Meals.",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          const SizedBox(height: 12),
          Text(
            'Try Selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(meal: meals[index], onToggleFevouriteMeal: onToggleFevouriteMeal)
        
        //  Text(
        //   meals[index].title,
        //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //         color: Theme.of(context).colorScheme.primary,
        //       ),
        // ),
        // style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        //           color: Theme.of(context).colorScheme.onBackground,
        //         ),
      );
    }
    if(title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
