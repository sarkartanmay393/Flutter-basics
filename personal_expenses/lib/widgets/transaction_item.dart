import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/Transaction.dart';

import '../models/transaction.dart' as tx;

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    @required Key key,
    @required this.tx,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.amber,
      Colors.orange,
      Colors.teal,
      Colors.green,
      Colors.deepPurple,
    ];

    _bgColor = availableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  "\$${widget.tx.price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            )),
        title: Text("${widget.tx.title}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text(
            "${DateFormat.yMMMd().format(widget.tx.date)}"),
        trailing: MediaQuery.of(context).size.width > 420
            ? TextButton.icon(
            onPressed: () =>
                widget.deleteTx(widget.tx.id),
            icon: Icon(Icons.delete_outline_outlined),
            label: Text("Delete"))
            : IconButton(
          onPressed: () =>
              widget.deleteTx(widget.tx.id),
          icon: Icon(Icons.delete_outline_outlined),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
