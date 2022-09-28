import 'dart:convert';

import 'package:http/http.dart';
import 'package:quizu/core/constances/api.dart';
import 'package:quizu/core/models/leaderboard.dart';
import 'package:quizu/core/models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/models/user.dart';

class API {
  Future<Response> login(String otp, String phone) async {
    Map<String, String> body = {"OTP": otp, "mobile": phone};
    Response response = await post(Uri.parse(kApiLoginURL), body: body);
    return response;
  }

  Future<Response> setName(String name) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    Map<String, String> body = {"name": name};

    Response response = await post(Uri.parse(kApiNameURL), body: body, headers: headers);
    return response;
  }

  Future<List<Question>> fetchQuestions() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(kApiQuestionsURL), headers: headers);
    List<dynamic> questionJson = json.decode(response.body);
    List<Question> questions = questionJson.map((json) => Question.fromJson(json)).toList();
    return questions;
  }

  Future<List<LeaderboardScore>> fetchLeaders() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(kApiTopURL), headers: headers);
    List<dynamic> leadersJson = json.decode(response.body);
    List<LeaderboardScore> leaders = leadersJson.map((json) => LeaderboardScore.fromJson(json)).toList();
    return leaders;
  }

  Future<User> fetchUser() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await get(Uri.parse(kApiInfoURL), headers: headers);
    dynamic userJson = json.decode(response.body);
    User user = User.fromJson(userJson);
    return user;
  }

  Future<Response> setScore(String score) async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {"score": score};

    Response response = await post(Uri.parse(kApiScoreURL), body: body, headers: headers);
    return response;
  }
}

extension IsOk on Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}
