import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/main_drawer.dart';
import './meal_screen.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> currentFilterData;
  final Function saveFilter;
  FiltersScreen(this.currentFilterData, this.saveFilter);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  initState () {
    _isVegetarian = widget.currentFilterData["vegetarian"];
    _isVegan = widget.currentFilterData["vegan"];
    _isLactoseFree = widget.currentFilterData["lactose"];
    _isGlutenFree = widget.currentFilterData["gluten"];
    super.initState();
  }

  Widget buildSwitchTile(String titleText, String subtitleText, bool keyValue,
      Function updateKeyValue) {
    return SwitchListTile(
      title: Text(
        titleText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
      subtitle: Text(
        subtitleText,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      value: keyValue,
      onChanged: updateKeyValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meal.recipe",
          style: TextStyle(
              color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(onPressed: () {
          final filters = {
            "gluten": _isGlutenFree,
            "lactose": _isLactoseFree,
            "vegan": _isVegan,
            "vegetarian": _isVegetarian,
          };
          widget.saveFilter(filters);
          Navigator.of(context).popAndPushNamed('/');
        }, icon: Icon(Icons.save_rounded))],
      ),
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            child: Text(
              "Select Filters :",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTile("Vegan", "Shows only vegan foods", _isVegan,
                    (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }),
                buildSwitchTile(
                    "Vegetarian", "Shows only vegetarian foods", _isVegetarian,
                    (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }),
                buildSwitchTile("Gluten Free", "Shows only gluten free foods",
                    _isGlutenFree, (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }),
                buildSwitchTile("Lactose Free", "Shows only lactose free foods",
                    _isLactoseFree, (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
