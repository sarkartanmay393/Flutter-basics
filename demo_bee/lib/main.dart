import 'package:demo_bee/screens/homepage.dart';
import 'package:demo_bee/screens/profilepage.dart';
import 'package:demo_bee/screens/tabview.dart';
import 'package:flutter/material.dart';

import 'widgets/edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo-BEE',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.red,
        backgroundColor: Colors.grey.shade200,
        canvasColor: Colors.grey.shade200,
      ),
      home: TabView(),
      routes: {
        TabView.routeName: (context) => TabView(),
        HomePage.routeName: (context) => HomePage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        // Edit.routeName: (context) => Edit(),
      },
    );
  }
}
