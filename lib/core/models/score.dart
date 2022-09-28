import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Score {
  String score;
  String date;
  Score({
    @required this.score,
    @required this.date,
  });

  Score.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        date = json['date'];
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'date': date,
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      score: map['score'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
