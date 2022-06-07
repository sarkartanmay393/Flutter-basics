import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products-provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "/productdetails";

  @override
  Widget build(BuildContext context) {
    String ID = ModalRoute.of(context).settings.arguments;
    final productData =
        Provider.of<Products>(context, listen: false).searchByID(ID);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                "Product Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Hero(
                tag: productData.id,
                child: Image.network(
                  productData.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                "\$${productData.price}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${productData.title}",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 20,
                indent: 40,
                endIndent: 40,
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                child: Text(
                  "${productData.description}",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
