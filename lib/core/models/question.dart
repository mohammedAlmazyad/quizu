// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Question {
  String question;
  String a;
  String b;
  String c;
  String d;
  String correct;
  Question({
    @required this.question,
    @required this.a,
    @required this.b,
    @required this.c,
    @required this.d,
    @required this.correct,
  });

  Question.fromJson(Map<String, dynamic> json)
      : question = json['Question'],
        a = json['a'],
        b = json['b'],
        c = json['c'],
        d = json['d'],
        correct = json['correct'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      'correct': correct,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] as String,
      a: map['a'] as String,
      b: map['b'] as String,
      c: map['c'] as String,
      d: map['d'] as String,
      correct: map['correct'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
