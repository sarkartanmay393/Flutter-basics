import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_item.dart';
import '../models/Transaction.dart';

class transactions extends StatelessWidget {
  // Transaction list database.
  final List<Transaction> transactionslistClone;
  Function _deleteTx;

  transactions(this.transactionslistClone, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactionslistClone.isEmpty
        ? Column(
      children: [
        Text(
          "No Transactions 🙅🏽",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    )
        : ListView(
      children: transactionslistClone.map((tx) => TransactionItem(
        key: ValueKey(tx.id),
        tx: tx,
        deleteTx: _deleteTx,
      ))
          .toList(),
    );
  }
}
