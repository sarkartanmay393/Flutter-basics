import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions.dart';
import './widgets/chart.dart';
import './models/Transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]); for blocking other orientation.
  runApp(MyApp());
}

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

  void _addNewTransaction({@required String txTitle, @required double txPrice, @required DateTime txDate}) {
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
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      // isScrollControlled: true,
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

  bool _showChart = true;

  @override
  Widget build(BuildContext context) {
    final isIos = Platform.isIOS;

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("PERSONAL EXPENSES"),
      actions: [
        IconButton(
          onPressed: () => _StartTheProcessofAddNewTx(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final iosAppBar = CupertinoNavigationBar(
      middle: Text("PERSONAL EXPENSES"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _StartTheProcessofAddNewTx(context),
            child: Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );

    final pageBody = SafeArea(child: SingleChildScrollView(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch.adaptive(
                activeColor: Colors.purple,
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                },
              ),
            ],
          ),
        if (_showChart || !isLandscape)
          Container(
              height: isLandscape
                  ? (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.67
                  : (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.23,
              child: Chart(_recentTx)),
        if (!isLandscape || !_showChart)
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.77,
              child: transactions(_userTransactionsList, _deleteTx)),
      ],
    )));

    return isIos
        ? CupertinoPageScaffold(
        navigationBar: iosAppBar,
        child: pageBody
        )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _StartTheProcessofAddNewTx(context),
                  ),
          );
  }
}
