// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:quizu/ui/view/otp.dart';
import 'package:quizu/ui/view/question.dart';

import '../../app.dart';
import '../../core/api.dart';
import '../../core/constances/decorations.dart';
import '../../core/models/question.dart';
import '../../core/providers/quizProvider.dart';
import '../../core/providers/userProvider.dart';
import '../widgets/appButton.dart';
import '../widgets/progress_dialog.dart';

ProgressDialog pr;

class HomeView extends StatefulWidget {
  const HomeView({
    Key key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    var quiz = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                        height: 82,
                        width: 82,
                        // decoration: BoxDecoration(
                        //   color: Color(0xfffedeef2),
                        //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        // ),
                        child: Hero(
                          child: Image.asset(kOkoulLogo),
                          tag: 'Okoul',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Text(
                        'Ready to test your knowledge and challenge others?',
                        style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    AppButton(
                      text: 'Start',
                      function: () async {
                        pr = ProgressDialog(context);
                        await pr.show();
                        if (quiz?.question == null) {
                          List<Question> question = await API().fetchQuestions();
                          quiz.setQuestion(question);
                          // pr.hide();
                        }
                        await pr.hide();
                        Navigator.pushNamed(context, '/QuestionView');
                      },
                    ),
                    Center(
                      child: Text(
                        'Answer as much questions correctly within 2 minutes',
                        style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
