import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import '../theme.dart';

import './favorites_screen.dart';
import './category_screen.dart';

class tabScreenframe extends StatefulWidget {

  final Function toggleFav;
  final Function isFav;
  List<Meal> fav;
  tabScreenframe(this.isFav, this.toggleFav, this.fav);

  @override
  State<tabScreenframe> createState() => _tabScreenframeState();
}

class _tabScreenframeState extends State<tabScreenframe> {

  List<Widget> _pages;

  @override
  initState() {
    _pages = [
      categoryScreen(),
      favoritesScreen(widget.isFav, widget.toggleFav, widget.fav),
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: universal_appbar,
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category_rounded), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
      ),
    );
  }
}
