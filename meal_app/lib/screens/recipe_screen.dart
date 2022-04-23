import 'package:flutter/material.dart';
import '../theme.dart';
import '../dummy-data.dart';

class recipe_screen extends StatelessWidget {
  static const routeName = '/recipe_screen';

  @override
  Widget build(BuildContext context) {
    final meal_id = ModalRoute.of(context).settings.arguments as String;
    final seletedMeal = DUMMY_MEALS.firstWhere((meal) => meal_id == meal.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          seletedMeal.title,
          style: TextStyle(
              color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Container(
        child: Image.network(seletedMeal.imageUrl),
      ),
    );
  }
}
