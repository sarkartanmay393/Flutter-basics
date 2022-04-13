import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                elevation: 1,
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            "\$${transactionslistClone[index].price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                  title: Text("${transactionslistClone[index].title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text(
                      "${DateFormat.yMMMd().format(transactionslistClone[index].date)}"),
                  trailing: MediaQuery.of(context).size.width > 420
                      ? TextButton.icon(
                          onPressed: () =>
                              _deleteTx(transactionslistClone[index].id),
                          icon: Icon(Icons.delete_outline_outlined),
                          label: Text("Delete"))
                      : IconButton(
                          onPressed: () =>
                              _deleteTx(transactionslistClone[index].id),
                          icon: Icon(Icons.delete_outline_outlined),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactionslistClone.length,
          );
  }
}
