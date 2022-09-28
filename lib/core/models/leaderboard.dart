import 'package:flutter/material.dart';

class LeaderboardScore {
  final String name;
  final int score;

  LeaderboardScore({@required this.name, @required this.score});

  LeaderboardScore.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        score = json['score'];
}
