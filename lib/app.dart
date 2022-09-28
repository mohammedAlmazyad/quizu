// ignore_for_file: prefer_const_constructors

// import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:quizu/core/models/question.dart';
import 'package:quizu/ui/view/home.dart';
import 'package:quizu/ui/view/leaderboard.dart';
import 'package:quizu/ui/view/login.dart';
import 'package:quizu/ui/view/otp.dart';
import 'package:quizu/ui/view/profile.dart';
import 'package:quizu/ui/view/question.dart';
import 'package:quizu/ui/view/resetName.dart';
import 'package:quizu/ui/view/score.dart';

import './core/constances/decorations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quizu/ui/widgets/bottomNavyBar.dart';

import 'core/providers/barProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: MyHomePage(),
      routes: {
        '/Home': (context) => const HomeView(),
        '/leaderboard': (context) => const leaderboardView(),
        '/ProfileView': (context) => const ProfileView(),
        '/QuestionView': (context) => const QuestionView(),
        '/ScoreView': (context) => const ScoreView(),
        '/Otp': (context) => const PinCodeVerificationScreen(),
        '/LoginView': (context) => LoginView(),
        '/ResetNameView': (context) => ResetNameView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bar = Provider.of<BarProvider>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(title: Text("Flutter Demo")),
      body: PageView(
        controller: bar.pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            // bar.onPageChanged(index);
          });
        },
        children: const <Widget>[HomeView(), leaderboardView(), ProfileView()],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            bar.changePage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Home'),
            activeColor: kPrimaryColor,
            inactiveColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.toc_sharp),
            title: Text('Catalog'),
            activeColor: kPrimaryColor,
            inactiveColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.person_alt),
            title: Text('Like'),
            activeColor: kPrimaryColor,
            inactiveColor: kPrimaryColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
