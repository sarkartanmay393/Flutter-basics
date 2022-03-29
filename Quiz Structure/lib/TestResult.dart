import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestResult extends StatelessWidget {
  final int score;
  final VoidCallback _resetHandler;
  TestResult(this.score, this._resetHandler);

  String get resultPhrase {
    String output;
    if(score >= 8) {
      output = "YOU ARE IMPRESSIVE! 🌸";
    } else if(score <= 4) {
      output = "YOU SHOULD STUDY 👋🏻";
    } else {
      output = "YOU ARE GOOD 🐣";
    }
    return output;
  }
  // Getter : a dart feature. How that work mentioned above.

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(resultPhrase,
            style: TextStyle(backgroundColor: Colors.purple, fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
            textAlign: TextAlign.center,

          ),
          FlatButton(child: Text("‣ RESET",
                style: TextStyle(fontWeight: FontWeight.bold,),),
            onPressed: _resetHandler,),

        ],
      ),
    );

  }
}
