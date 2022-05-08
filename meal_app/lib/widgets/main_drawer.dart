import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.teal,),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            child: Text(
              "Menu Bar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant, size: 26,),
            title: Text(
              "Meals",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 26,),
            title: Text(
              "Filter",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/filters');
            },
          ),
        ],
      ),
    );
  }
}
