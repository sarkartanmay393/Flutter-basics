import 'package:flutter/material.dart';

import '../models/meal.dart';
import './recipe_screen.dart';

class favoritesScreen extends StatefulWidget {
  List<Meal> fav;
  final Function toggleFav;
  final Function isFav;

  favoritesScreen(this.isFav, this.toggleFav, this.fav);

  @override
  State<favoritesScreen> createState() => _favoritesScreenState();
}

class _favoritesScreenState extends State<favoritesScreen> {


  void removeFavorite (String id) {
    setState(() {
      widget.fav.removeWhere((meal) => meal.id == id);
    });
  }

  void getIntoFavorite(BuildContext ctx, String id) {
    Navigator.of(ctx).pushNamed(recipe_screen.routeName, arguments: {
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fav.isEmpty) {
      return Center(
        child: Text(
          "You have no favorites.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 8),
            height: 45,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Your Favorites",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    getIntoFavorite(context, widget.fav[index].id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.teal,
                      image: DecorationImage(
                          image: Image.network(
                            widget.fav[index].imageUrl,
                          ).image,
                          fit: BoxFit.cover),
                    ),
                    height: 80,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Container(
                          //height: 0,
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                // text container
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Color.fromRGBO(5, 220, 189, 0.7),
                                      Color.fromRGBO(255, 255, 255, 1)
                                    ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight)),
                                padding: EdgeInsets.all(3.0),
                                child: Text("${widget.fav[index].title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      overflow: TextOverflow.fade,
                                      color: Colors.black87,
                                      letterSpacing: 0.5,
                                    )),
                              ),
                              IconButton(
                                  onPressed: () {
                                    removeFavorite(widget.fav[index].id);
                                  },
                                  iconSize: 35,
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.teal.shade500,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: widget.fav.length,
            ),
          ),
        ],
      );
    }
  }
}
