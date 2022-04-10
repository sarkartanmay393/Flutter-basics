import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// contains the new expense adder function.
class new_transaction extends StatefulWidget {
  final Function addNewTx;
  new_transaction(this.addNewTx);

  @override
  State<new_transaction> createState() => _new_transactionState();
}

class _new_transactionState extends State<new_transaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);
    final enteredDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredPrice <= 0 || _selectedDate == null)
      return;
    // if not entered proper-details, it will not add up into the transaction list.
    widget.addNewTx(
      // widget to use methods from other class.
      txTitle: enteredTitle,
      txPrice: enteredPrice,
      txDate: enteredDate,
    );
    Navigator.of(context) 
        .pop(); // for closing the showModalBottomSheet, aftering confirming tx data.
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(fontWeight: FontWeight.w500)),
              keyboardType: TextInputType.text,
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Price",
                  labelStyle: TextStyle(fontWeight: FontWeight.w500)),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: priceController,
              onSubmitted: (_) => submitData(),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? "Date : Not Picked"
                        : "Date : ${DateFormat.yMd().format(_selectedDate)}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton.icon(
                    onPressed: _showDatePicker,
                    icon: Icon(Icons.calendar_month_outlined),
                    label: Text(
                      "Pick Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text("Add Transection"),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
