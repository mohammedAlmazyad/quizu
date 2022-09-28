// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:quizu/ui/view/otp.dart';
import 'package:quizu/ui/view/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';
import '../../core/api.dart';
import '../../core/constances/decorations.dart';
import '../../core/models/question.dart';
import '../../core/providers/quizProvider.dart';
import '../../core/providers/userProvider.dart';
import '../widgets/appButton.dart';
import '../widgets/progress_dialog.dart';
import 'package:share_plus/share_plus.dart';

ProgressDialog pr;

class ScoreView extends StatefulWidget {
  const ScoreView({Key key}) : super(key: key);

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);

    var user = Provider.of<UserProvider>(context, listen: false);
    var quiz = Provider.of<QuizProvider>(context, listen: false);
    void shareButton() {
      Share.share("I answered ${user.score} correct answers in QuizU!");
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          // ignore: void_checks
                          onPressed: () async {
                            final localStorage = await SharedPreferences.getInstance();

                            localStorage.clear();
                            user.logout();
                            return Navigator.pop(context);
                          },
                          icon: Icon(Icons.home),
                          color: kPrimaryColor,
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 82,
                          width: 82,
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
                          'Your Score is ${user.score}',
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
                          shareButton();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
