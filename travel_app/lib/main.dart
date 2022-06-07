import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/nearby_places.dart';
import './screens/HomeScreen.dart';
import './screens/PlaceAddingScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NearbyPlaces(),
      child: MaterialApp(
        title: 'Bhraman Bahak',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.green,
          backgroundColor: Colors.grey.shade200,
          canvasColor: Colors.grey.shade200,
          fontFamily: "Poppins",
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          PlaceAddingScreen.routeName: (context) => const PlaceAddingScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
