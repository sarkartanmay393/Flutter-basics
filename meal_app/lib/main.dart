import 'package:flutter/material.dart';
import './screens/meal_screen.dart';
import './screens/recipe_screen.dart';
import './screens/category_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        '/': (ctx) => categoryScreen(),
        meal_screen.routeName: (ctx) => meal_screen(),
        recipe_screen.routeName: (ctx) => recipe_screen(),
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