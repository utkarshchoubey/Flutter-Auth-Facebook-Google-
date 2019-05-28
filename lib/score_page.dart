import 'package:flutter/material.dart';
import 'landing_page.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestion;
  ScorePage(this.score, this.totalQuestion);
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blue,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Your score:",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontStyle: FontStyle.italic,
              )),
          new Text(
            score.toString() + "/" + totalQuestion.toString(),
            style: new TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.arrow_right),
            color: Colors.white,
            iconSize: 50.0,
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new LandingPage())),
          )
        ],
      ),
    );
  }
}
