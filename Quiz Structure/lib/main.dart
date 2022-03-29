import 'package:flutter/material.dart';
import './Questions.dart';
import './Answers.dart';
import './TestResult.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  static const _questionsDatabase = [
    {
    "questionText" : "What is the color of the Cosmos ?",
    "answers" : [
      {'text' : "Pale Turquoise", 'score' : 0},
      {'text' : "Aquamarine", 'score' : 0},
      {'text' : "Not Specific", 'score' : 2}
      ]
    },
    {"questionText" : "How far humans have went through the cosmos ?",
    "answers" : [
      {'text' : "90.9 Million Miles", 'score' : 0},
      {'text' : "12 Light Years", 'score' : 0},
      {'text' : "6.5 Billion Miles", 'score' : 2},
      {'text' : "3 Light Years", 'score' : 0}
      ]
    },
    {"questionText" : "What spacecraft has traveled the farthest from Earth ?",
    "answers" : [
      {'text' : "Voyager 1", 'score' : 2},
      {'text' : "Marun 58", 'score' : 0},
      {'text' : "Voyager 31", 'score' : 0}
      ]
    }
  ];

  Set<int> _TestResultDatabase = {0};
  // holds private test results.
  int _finalScore = 0;

  void _resetFunc(){
    setState(() {
      _questionIndex = 0;
      _finalScore = 0;
    });
  }

  void _ansQuestion(int score){

    _finalScore += score;

    setState(() {
      _questionIndex += 1;
    });
    if(_questionIndex < _questionsDatabase.length){
      print(_questionsDatabase.length - _questionIndex);
      print('More Questions to go ');
    } else {
      print('Test Complete!');
      print(_finalScore);
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.from(colorScheme: ColorScheme.dark()),
      home: Scaffold(
          appBar: AppBar(
            title: Text('QUIZ APP'),
          ),
          body: _questionIndex < _questionsDatabase.length ?
          Column(
            children: [
              Question(_questionsDatabase[_questionIndex]["questionText"]), // accessing Map in List
              ...(_questionsDatabase[_questionIndex]["answers"] as List<Map<String, Object>>).map((ans) {
                return Answers(() => _ansQuestion(ans['score']), ans['text']);
              }),
            ],
          ) : TestResult(_finalScore, _resetFunc),
      ),
    );
  }
}
