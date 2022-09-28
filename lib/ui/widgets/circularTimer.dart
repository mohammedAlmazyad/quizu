import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/app.dart';
import 'package:quizu/core/api.dart';
import 'package:quizu/core/models/score.dart';
import 'package:quizu/core/providers/userProvider.dart';
import 'package:quizu/ui/view/home.dart';
import 'package:quizu/ui/view/score.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constances/decorations.dart';
import '../../core/providers/quizProvider.dart';

class CircularTimer extends StatelessWidget {
  const CircularTimer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quiz = Provider.of<QuizProvider>(context, listen: false);
    var user = Provider.of<UserProvider>(context, listen: false);

    return CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: quiz.duration,

      // Countdown initial elapsed Duration in Seconds.
      initialDuration: 1,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: quiz.countDownController,

      // Width of the Countdown Widget.
      width: MediaQuery.of(context).size.width / 8,

      // Height of the Countdown Widget.
      height: MediaQuery.of(context).size.height / 8,

      // Ring Color for Countdown Widget.
      ringColor: Color(0xff1C706B),

      // Ring Gradient for Countdown Widget.
      ringGradient: null,

      // Filling Color for Countdown Widget.
      fillColor: kPrimaryColor,

      // Filling Gradient for Countdown Widget.
      fillGradient: null,

      // Background Color for Countdown Widget.
      backgroundColor: kBackgroundColor,

      // Background Gradient for Countdown Widget.
      backgroundGradient: null,

      // Border Thickness of the Countdown Ring.
      strokeWidth: 20.0,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.round,

      // Text Style for Countdown Text.
      textStyle: const TextStyle(
        fontSize: 33.0,
        color: kTextColor,
        fontWeight: FontWeight.w400,
      ),

      // Format for the Countdown Text.
      textFormat: CountdownTextFormat.S,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: true,

      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: true,

      // Handles visibility of the Countdown Text.
      isTimerTextShown: true,

      // Handles the timer start.
      autoStart: true,

      // This Callback will execute when the Countdown Ends.
      onComplete: () async {
        final localStorage = await SharedPreferences.getInstance();
        List<String> list = localStorage.getStringList('Scores');
        // ignore: prefer_conditional_assignment
        //check if the path is there
        if (list == null) {
          list = [];
        }
        int score = quiz.score;
        String time = DateTime.now().toIso8601String();
        // add to the local
        list.add(time);
        list.add(score.toString());
        localStorage.setStringList('Scores', list);
        // save the score to the user
        user.setScore(score);
        //save the score in the DB
        API().setScore(score.toString());
        // reset the provider
        quiz.reset();
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/ScoreView');
      },
    );
  }
}
