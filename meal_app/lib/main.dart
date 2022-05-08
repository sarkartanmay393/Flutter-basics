import 'package:flutter/material.dart';

import './dummy-data.dart';
import './models/meal.dart';
import './screens/filter_screen.dart';
import './screens/tabs_screenframe.dart';
import './screens/meal_screen.dart';
import './screens/recipe_screen.dart';
import './screens/category_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _toggleFavorite (String ID) {
    final matchedMealIndex = _favoriteMeal.indexWhere((meal) => meal.id == ID);
    if(matchedMealIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(matchedMealIndex);
      });
    } else {
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == ID));
      });
    }
  }

  bool _isFavorite (String id) {
    if(_favoriteMeal.isEmpty) {
      return false;
    }
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  void _saveFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if(_filters["gluten"] && !meal.isGlutenFree) {
          return false;
        }
        if(_filters["lactose"] && !meal.isLactoseFree) {
          return false;
        }
        if(_filters["vegan"] && !meal.isVegan) {
          return false;
        }
        if(_filters["vegetarian"] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal.recipe',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        canvasColor: Color(0xFFFFFFFF),
      ),

      initialRoute: '/',
      routes: {
        '/': (ctx) => tabScreenframe(_isFavorite, _toggleFavorite, _favoriteMeal),
        meal_screen.routeName: (ctx) => meal_screen(_availableMeal),
        recipe_screen.routeName: (ctx) => recipe_screen(_isFavorite, _toggleFavorite, _favoriteMeal),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _saveFilters),

      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   // if (settings.name == '/meal-detail') {
      //   //   return ...;
      //   // } else if (settings.name == '/something-else') {
      //   //   return ...;
      //   // }
      //   // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => categoryScreen());
      },
    );
  }
}