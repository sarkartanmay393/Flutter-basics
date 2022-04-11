import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions.dart';
import './widgets/chart.dart';
import './models/Transaction.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "OpenSans",
        textTheme: ThemeData.light().textTheme.copyWith(
                button: TextStyle(
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ), // used appbar variable.
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactionsList = [
    Transaction(id: "t1", title: "New Shoes", price: 98, date: DateTime.now()),
    Transaction(
        id: "t2",
        title: "Groceries",
        price: 14.5,
        date: DateTime.parse("2022-04-09")),
    Transaction(
        id: "t3",
        title: "Screen Protector",
        price: 20.1,
        date: DateTime.parse("2022-04-08")),
    Transaction(
        id: "t5",
        title: "Body Spray",
        price: 2.5,
        date: DateTime.parse("2022-04-07")),
    Transaction(
        id: "t4", title: "Extension Board", price: 31.5, date: DateTime.now()),
    Transaction(
        id: "t6",
        title: "Airpods 2",
        price: 169,
        date: DateTime.parse("2022-04-07")),
    Transaction(
        id: "t7",
        title: "Macbook Air M1",
        price: 899,
        date: DateTime.parse("2022-04-05")),
    Transaction(
        id: "t8",
        title: "Laptop Sleeve",
        price: 5.34,
        date: DateTime.parse("2022-04-06")),
    Transaction(
        id: "t9",
        title: "Eye Glass",
        price: 50.2,
        date: DateTime.parse("2022-04-08")),
    // new transactions will be added to this reference list.
  ];

  void _addNewTransaction({String txTitle, double txPrice, DateTime txDate}) {
    final txNew = Transaction(
      title: txTitle,
      price: txPrice,
      date: txDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactionsList.add(txNew);
    });
  }

  void _StartTheProcessofAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: new_transaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactionsList.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTx {
    return _userTransactionsList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("PERSONAL EXPENSES"),
      actions: [
        IconButton(
          onPressed: () => _StartTheProcessofAddNewTx(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.23,
              child: Chart(_recentTx)),
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.77,
              child: transactions(_userTransactionsList, _deleteTx)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _StartTheProcessofAddNewTx(context),
      ),
    );
  }
}
