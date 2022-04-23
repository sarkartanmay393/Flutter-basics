import 'package:flutter/material.dart';
import '../theme.dart';
import '../screens/meal_screen.dart';

class category_item extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  category_item(@required this.id, @required this.title, this.color);

  void seleteCategory(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(meal_screen.routeName, arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => seleteCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          "$title",
          style: gridText,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      splashColor: Color.fromRGBO(85, 85, 85, 61),
    );
  }
}
