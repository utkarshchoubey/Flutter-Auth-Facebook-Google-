import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'quiz_page.dart';

class LandingPage extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return new Material(
    color:Color.fromARGB(255, 255,25,255),
      child: InkWell(

        onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=>new QuizPage())),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Lets Quiz",style: new TextStyle(color: Colors.white,fontSize: 50.0,fontWeight:FontWeight.bold)),
            new Text("Tap to start",style: new TextStyle(color: Colors.white,fontSize: 20.0,fontWeight:FontWeight.bold),),
          ],
        ),
      ),
    );
  }
  }
