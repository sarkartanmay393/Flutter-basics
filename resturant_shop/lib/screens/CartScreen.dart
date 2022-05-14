import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order-provider.dart';
import '../providers/cart-provider.dart' show Cart;
import '../widgets/cart-card.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart_screen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "SHOPPING CART",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red),
      body: cartData.cart_items.length == 0
          ? Center(
              child: Text("No Cart Item Added"),
            )
          : Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL AMOUNT :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        //Spacer(),
                        Chip(
                          backgroundColor: Colors.red.shade50,
                          label: Text(
                              "${cartData.totalAmount.toStringAsFixed(2)}"),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          labelPadding: EdgeInsets.all(1),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                              fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              Provider.of<Order>(context, listen: false)
                                  .addOrder(cartData.totalAmount,
                                  cartData.cart_items.values.toList());
                              cartData.clear();
                            });
                          },
                          child: Text(
                            "ORDER NOW",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      return Cart_Card(
                        serialNo: i + 1,
                        id: cartData.cart_items.values.toList()[i].id,
                        title: cartData.cart_items.values.toList()[i].title,
                        price: cartData.cart_items.values.toList()[i].price,
                        quantity:
                            cartData.cart_items.values.toList()[i].quantity,
                        imageUrl:
                            cartData.cart_items.values.toList()[i].imageUrl,
                      );
                    },
                    itemCount: cartData.cartItemsCount,
                  ),
                ),

              ],
            ),
    );
  }
}
