import 'package:demo_bee/screens/helppage.dart';
import 'package:demo_bee/screens/homepage.dart';
import 'package:demo_bee/screens/inventory.dart';
import 'package:demo_bee/screens/profilepage.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  static const routeName = "Tab";
  TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int selectedIndex = 0;

  void selecter(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  List<Widget> diffItems = [
    HomePage(),
    HelpPage(),
    InventoryPage(),
    ProfilePage(),
  ];

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            "BEE",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
              )),
        ),
      ),
      drawer: Drawer(),
      body: diffItems[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: selecter,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center_outlined),
            label: "Get Help",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: "Inventory",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
