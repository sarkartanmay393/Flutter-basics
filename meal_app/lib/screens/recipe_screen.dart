import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../theme.dart';
import '../dummy-data.dart';

class recipe_screen extends StatelessWidget {
  static const routeName = '/recipe_screen';

  final Function toggleFav;
  final Function isFav;
  final List<Meal> fav;
  recipe_screen(this.isFav, this.toggleFav, this.fav);

  @override
  Widget build(BuildContext context) {
    final finalArg =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final meal_id = finalArg['id'];
    final seletedMeal = DUMMY_MEALS.firstWhere((meal) => meal_id == meal.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          seletedMeal.title,
          style: TextStyle(
              color: kWhiteColor, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(seletedMeal.imageUrl, fit: BoxFit.cover),
                Positioned(
                  left: 23,
                  bottom: 15,
                  child: Text(
                    seletedMeal.title,
                    style: TextStyle(
                        backgroundColor: Colors.teal,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "INGREDIENTS",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              width: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal, width: 4),
                borderRadius: BorderRadius.circular(6),
                color: Colors.teal,
                backgroundBlendMode: BlendMode.darken,
              ),
              margin: EdgeInsets.all(5),
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  margin: EdgeInsets.all(3.5),
                  shadowColor: Colors.white,
                  borderOnForeground: true,
                  color: Colors.teal,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      seletedMeal.ingredients[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                itemCount: seletedMeal.ingredients.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "STEPS",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal, width: 3),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      title: Text(
                        seletedMeal.steps[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: seletedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: isFav(seletedMeal.id) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          onPressed: () {
            //Navigator.of(context).pop(meal_id);
            toggleFav(seletedMeal.id);
            },
      ),
    );
  }
}
