import 'dart:ui';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain obj = new QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(245, 225, 68, 1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.lightbulb_outline,
                size: 30.0,
                color: Colors.blueGrey.shade900,
              ),
              Text(
                ' QUIZZLER !',
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 25,
                  letterSpacing: 5,
                  color: Color.fromRGBO(45, 58, 76, 1),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int score = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = obj.getQuestionAns();

    setState(() {
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (obj.isFinished() == true) {
        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished! 😎😎',
          desc:
              'You\'ve reached the end of the quiz, with a score of $score/13.',
        ).show();

        obj.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          score++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        obj.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                obj.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color.fromRGBO(45, 58, 76, 1),
                  fontFamily: 'Myriad',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              animationDuration: Duration(milliseconds: 100),
              color: Color.fromRGBO(45, 58, 76, 1),
              splashColor: Colors.grey.shade900,
              highlightColor: Colors.grey.shade900,
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Color.fromRGBO(245, 225, 68, 1.0),
                  fontSize: 20.0,
                  fontFamily: 'Audiowide',
                  letterSpacing: 5.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
              animationDuration: Duration(milliseconds: 30),
              color: Color.fromRGBO(45, 58, 76, 1),
              splashColor: Colors.grey.shade900,
              highlightColor: Colors.grey.shade900,
              child: Text(
                'FALSE',
                style: TextStyle(
                  fontFamily: 'Audiowide',
                  letterSpacing: 5.0,
                  fontSize: 20.0,
                  color: Color.fromRGBO(245, 225, 68, 1),
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
