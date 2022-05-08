import 'package:flutter/material.dart';

import '../theme.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class meal_screen extends StatefulWidget {
  static const routeName = "/meal_screen";

  List<Meal> meals;
  meal_screen(this.meals);

  @override
  State<meal_screen> createState() => _meal_screenState();
}

class _meal_screenState extends State<meal_screen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _databaseLoaded = false;

  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_databaseLoaded) {
      final finalArg =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      final categoryId = finalArg['id'];
      categoryTitle = finalArg['title'];
      displayedMeals = widget.meals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    _databaseLoaded = true;
  }
    super.didChangeDependencies();
  }

  void removeItem(String meal_id) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == meal_id);
    });
  }

  @override
  Widget build(BuildContext context) {


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
            title: displayedMeals[count].title,
            id: displayedMeals[count].id,
            duration: displayedMeals[count].duration,
            complexity: displayedMeals[count].complexity,
            affordability: displayedMeals[count].affordability,
            imageUrl: displayedMeals[count].imageUrl,
            removeItem: removeItem,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
