import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order-provider.dart';
import '../widgets/order-card.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final OrderProviderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, OrderIndex) => OrderItemView(
                  OrderIndex
                ),
                itemCount: OrderProviderData.OrderList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
