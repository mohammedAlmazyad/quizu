import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quizu/app.dart';
import 'package:quizu/core/providers/barProvider.dart';
import 'package:quizu/core/providers/quizProvider.dart';
import 'package:quizu/ui/view/home.dart';
import 'package:quizu/ui/view/leaderboard.dart';
import 'package:quizu/ui/view/login.dart';
import 'package:quizu/ui/view/otp.dart';
import 'package:quizu/ui/view/profile.dart';
import 'package:quizu/ui/view/question.dart';
import 'package:quizu/ui/view/resetName.dart';
import 'package:quizu/ui/view/score.dart';

import 'core/providers/userProvider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BarProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      routes: {
        '/Route': (context) => MyApp(),
        '/Otp': (context) => const PinCodeVerificationScreen(),
        '/Home': (context) => const HomeView(),
        '/leaderboard': (context) => const leaderboardView(),
        '/ProfileView': (context) => const ProfileView(),
        '/QuestionView': (context) => const QuestionView(),
        '/ScoreView': (context) => const ScoreView(),
        '/LoginView': (context) => LoginView(),
        '/ResetNameView': (context) => ResetNameView(),
      },
    );
  }
}
