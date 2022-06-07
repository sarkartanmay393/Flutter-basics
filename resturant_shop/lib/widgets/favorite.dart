import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products-provider.dart';
import 'product-card.dart';

class Favorite extends StatefulWidget {
  static const routeName = "/favorite";

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).favoriteItems;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SHOP",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text("Favorites",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (_, i) => Column(
                  children: [
                    ListTile(
                      title: Text(
                        products[i].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(products[i].imageUrl),
                        // backgroundImage: NetworkImage(products[i].imageUrl),
                      ),
                      subtitle: Text("\$${products[i].price}"),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: products.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
