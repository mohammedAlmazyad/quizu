import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  List<Question> _question;
  int _index = 0;
  int _score = 0;
  int _duration = 120;
  int _totalQuestions;
  int _skipedIndex;
  int _count = 0;
  CountDownController _controller = CountDownController();
  bool _skiped = false;
  List<int> _setOfIndex = [];

  CountDownController get countDownController {
    return _controller;
  }

  int get duration {
    return _duration;
  }

  int get totalQuestions {
    return _totalQuestions;
  }

  int get count {
    return _count;
  }

  void setTotalQuestions(int totalQuestions) {
    _totalQuestions = totalQuestions;
    notifyListeners();
  }

  void setQuestion(List<Question> question) {
    _question = question;
    _totalQuestions = question.length;
    // to make it Random
    for (var i = 1; i < _totalQuestions + 1; i++) {
      _setOfIndex.add(i);
    }
    _setOfIndex.shuffle();
    _index = _setOfIndex.elementAt(_count);
    notifyListeners();
  }

  List<Question> get question {
    return _question;
  }

  bool incrementIndex() {
    if (_count + 1 < totalQuestions) {
      _count++;
      _index = _setOfIndex.elementAt(_count);
      _setOfIndex.remove(_setOfIndex.elementAt(_index));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  int get index {
    return _index;
  }

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    _setOfIndex = [];
    // to make it Random
    for (var i = 1; i < _totalQuestions + 1; i++) {
      _setOfIndex.add(i);
    }
    _setOfIndex.shuffle();
    _index = _setOfIndex.elementAt(_count);
    _skiped = false;
    _score = 0;
    notifyListeners();
  }

  int get score {
    return _score;
  }

  bool checkAnswer(Question question, String answer) {
    if (answer == question.correct) {
      incrementScore();
      incrementIndex();
      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

  void skip() {
    _skipedIndex = _index;
    incrementIndex();
    _skiped = true;
  }

  bool get skiped {
    return _skiped;
  }

  int get skipedIndex {
    return _skipedIndex;
  }

  @override
  void dispose() {
    _index = 0;
    _duration = 120;
    super.dispose();
  }
}
