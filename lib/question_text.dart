import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class question_text extends StatefulWidget {
  final String _question;
  final int _questionNumber;
  question_text(this._question, this._questionNumber);
  @override
  State createState() => new question_textState();
}

class question_textState extends State<question_text>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;
  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizeAnimationController, curve: Curves.bounceInOut);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(question_text oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Padding(
      padding: new EdgeInsets.symmetric(vertical: 20.0),
      child: new Center(
        child: new Text(
            "Statement " +
                widget._questionNumber.toString() +
                "=> " +
                widget._question,
            style: new TextStyle(fontSize: _fontSizeAnimation.value * 15)),
      ),
    ));
  }
}
