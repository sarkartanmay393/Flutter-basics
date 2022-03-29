import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final VoidCallback selectHandler;
  String ansText;
  Answers(this.selectHandler, this.ansText);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(2),
      child: ElevatedButton(
        child: Text(ansText),
        onPressed: selectHandler,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white
        ),

        //Anonymous Function
      )
    );
  }
}
