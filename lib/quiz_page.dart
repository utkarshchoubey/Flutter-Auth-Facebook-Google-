import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'question.dart';
import 'quiz.dart';
import 'answer_button.dart';
import 'question_text.dart';
import 'correct_wrong_overlay.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Utkarsh is Cool?", true),
    new Question("Elon Mask is a human?", false),
    new Question("Pizza is healthy", false),
    new Question("Flutter is Awesome", true),
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlay_should_be_visible = false;
  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionNumber = quiz.questionNumber;
    questionText = currentQuestion.question;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.ans == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlay_should_be_visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () {
              handleAnswer(true);
            }),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () {
              handleAnswer(false);
            }),
          ],
        ),
        overlay_should_be_visible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ScorePage(quiz.score, quiz.length)));
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  overlay_should_be_visible = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : new Container(),
      ],
    );
  }
}
