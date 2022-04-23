import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTx;
  Chart(this.recentTx);

  List<Map<String, Object>> get groupedTxValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (int i = 0; i < recentTx.length; i++) {
        if (recentTx[i].date.day == weekDay.day &&
            recentTx[i].date.month == weekDay.month &&
            recentTx[i].date.year == weekDay.year) {
          totalSum += recentTx[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'price': totalSum,
      };
    }).toList();
  }

  double get totalSpending {
    return groupedTxValues.fold(0.0, (sum, item) {
      return sum + item['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTxValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['price'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['price'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
