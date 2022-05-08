import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/meal.dart';
import '../screens/recipe_screen.dart';
import '../theme.dart';

class meal_item extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;
  final int duration;
  final Function removeItem;

  meal_item(
      {this.title,
      this.id,
      this.imageUrl,
      this.complexity,
      this.affordability,
      this.duration,
      this.removeItem});

  void getintorecipe(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(recipe_screen.routeName, arguments: {
      'id': id,
      'complexity': complexityText,
      'affordability': affordabilityText
    }).then((meal_id) {
      if(meal_id != null) {
        removeItem(meal_id);
      }
    });
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Easy";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Luxurious:
        return "Luxurios";
      case Affordability.Pricey:
        return "Expensive";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => getintorecipe(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(0),
                  color: Color(0x81FFFFFF),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.timer_rounded, color: Colors.teal),
                label: Text("$duration min",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.w700)),
              ),
              TextButton.icon(
                icon: Icon(Icons.food_bank_rounded, color: Colors.teal),
                label: Text("$complexityText",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.w700)),
              ),
              TextButton.icon(
                icon: Icon(Icons.monetization_on_rounded, color: Colors.teal),
                label: Text("$affordabilityText",
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
