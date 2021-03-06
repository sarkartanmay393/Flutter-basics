import 'package:demo_bee/widgets/categories.dart';
import 'package:demo_bee/widgets/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/homecard.dart';

class HomePage extends StatelessWidget {
  static const routeName = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Here",
                    hintStyle: TextStyle(
                      fontSize: 12,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                  ),
                  // textInputAction: TextInputAction.search,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 0.5,
                    ),
                    color: Colors.grey.shade300,
                  ),
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 9,
                  ),
                  child: IconButton(
                    iconSize: 15,
                    onPressed: () {},
                    icon: const Icon(Icons.search_outlined),
                  ),
                ),
              ],
            ),
          ),
          const homecard(),
          const Categories(),
          const Services(),
        ],
      ),
    );
  }
}
