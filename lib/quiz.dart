import 'question.dart';

class Quiz {
  List<Question> _question;
  int _currentQuestionIndex = -1;
  int _score = 0;

  Quiz(this._question) {
    _question.shuffle();
  }
  int get score => _score;
  List<Question> get question => _question;
  int get length => _question.length;
  int get questionNumber => _currentQuestionIndex + 1;
  Question get nextQuestion {
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= length) return null;
    return _question[_currentQuestionIndex];
  }

  void answer(bool isCorrect) {
    if (isCorrect) _score++;
  }
}
