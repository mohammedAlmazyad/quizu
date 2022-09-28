// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:quizu/core/constances/decorations.dart';
import 'package:quizu/core/providers/quizProvider.dart';
import 'package:quizu/ui/widgets/answerButton.dart';

import '../widgets/appButton.dart';

import '../widgets/circularTimer.dart';
import '../widgets/dialog.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({
    Key key,
  }) : super(key: key);

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    var quiz = Provider.of<QuizProvider>(context, listen: false);
    // WillPopScope To make sure that the user don't leave the page
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      quiz.countDownController.pause();
                      quiz.countDownController.restart();
                      quiz.reset();
                      Navigator.pop(context);
                    },
                    backgroundColor: kBackgroundColor,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(top: 10),
                    children: [
                      CircularTimer(),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Question ${(quiz.count + 1).toString()} of ${quiz.totalQuestions.toString()}',
                        style: TextStyle(fontSize: 20, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          height: 100,
                          child: Text(
                            quiz.question[quiz.index].question,
                            style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AnswerButton(
                                question: 'A',
                                answer: quiz.question[quiz.index].a,
                                function: () {
                                  setState(() {
                                    bool answer = quiz.checkAnswer(quiz.question[quiz.index], 'a');
                                    if (!answer) {
                                      quiz.countDownController.pause();
                                      setState(() {
                                        WrongAnswer(quiz, context);
                                      });
                                    }
                                  });
                                },
                              ),
                              AnswerButton(
                                question: 'B',
                                answer: quiz.question[quiz.index].b,
                                function: () {
                                  setState(() {
                                    bool answer = quiz.checkAnswer(quiz.question[quiz.index], 'b');
                                    if (!answer) {
                                      quiz.countDownController.pause();

                                      setState(() {
                                        WrongAnswer(quiz, context);
                                      });
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AnswerButton(
                                question: 'C',
                                answer: quiz.question[quiz.index].c,
                                function: () {
                                  setState(() {
                                    bool answer = quiz.checkAnswer(quiz.question[quiz.index], 'c');
                                    if (!answer) {
                                      quiz.countDownController.pause();
                                      setState(() {
                                        WrongAnswer(quiz, context);
                                      });
                                    }
                                  });
                                },
                              ),
                              AnswerButton(
                                question: 'D',
                                answer: quiz.question[quiz.index].d,
                                function: () {
                                  setState(() {
                                    bool answer = quiz.checkAnswer(quiz.question[quiz.index], 'd');
                                    if (!answer) {
                                      quiz.countDownController.pause();
                                      setState(() {
                                        WrongAnswer(quiz, context);
                                      });
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      !quiz.skiped
                          ? AppButton(
                              text: 'Skip',
                              function: () {
                                setState(() {
                                  quiz.skip();
                                });
                              },
                            )
                          : Container(),
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

void WrongAnswer(QuizProvider quiz, context) {
  quiz.countDownController.pause();
  CustomDialog.error(
      message: 'Wrong Answer',
      button2Text: 'Try again',
      buttonText: 'Exit',
      context: context,
      button2Action: () {
        quiz.countDownController..restart();

        Navigator.popAndPushNamed(context, '/QuestionView');
        quiz.reset();
      },
      onAction: () {
        quiz.countDownController.restart();
        quiz.reset();
        Navigator.pop(context);
      });
}
