import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/theme.dart';
import '../models/meal.dart';
import '../dummy-data.dart';
import '../widgets/mean_item.dart';

class meal_screen extends StatelessWidget {
  static const routeName = "/meal_screen";

  @override
  Widget build(BuildContext context) {
    final finalArg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final categoryId = finalArg['id'];
    final categoryTitle = finalArg['title'];
    final List<Meal> categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: TextStyle(
              color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, count) {
          return meal_item(
            title: categoryMeals[count].title,
            id: categoryMeals[count].id,
            duration: categoryMeals[count].duration,
            complexity: categoryMeals[count].complexity,
            affordability: categoryMeals[count].affordability,
            imageUrl: categoryMeals[count].imageUrl,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
