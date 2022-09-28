// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizu/core/models/leaderboard.dart';
import 'package:quizu/ui/view/otp.dart';

import '../../app.dart';
import '../../core/api.dart';
import '../../core/constances/decorations.dart';
import '../../core/providers/userProvider.dart';
import '../widgets/appButton.dart';

class leaderboardView extends StatefulWidget {
  const leaderboardView({
    Key key,
  }) : super(key: key);

  @override
  State<leaderboardView> createState() => _leaderboardViewState();
}

class _leaderboardViewState extends State<leaderboardView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      // extendBodyBehindAppBar: true,

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
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
                        'Leaderboard',
                        style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FutureBuilder<List<LeaderboardScore>>(
                        future: API().fetchLeaders(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: 25),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    if (user.userName != snapshot.data[index].name) {
                                      return Card(
                                        color: Colors.white,
                                        child: ListTile(
                                            // leading: Container(child: Text(snapshot.data[index].name)),
                                            leading: Text((index + 1).toString()),
                                            title: Text(snapshot.data[index].name),
                                            trailing: Text(snapshot.data[index].score.toString())),
                                      );
                                    } else {
                                      return Card(
                                        color: Colors.white,
                                        child: ListTile(
                                            // leading: Container(child: Text(snapshot.data[index].name)),
                                            leading: Text((index + 1).toString()),
                                            title: Column(
                                              children: [
                                                Text(snapshot.data[index].name),
                                                Text('it is You! 🌚🔥'),
                                              ],
                                            ),
                                            trailing: Text(snapshot.data[index].score.toString())),
                                      );
                                    }
                                  }),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text('the is an error'));
                          } else {
                            return Center(
                              child: Lottie.asset('assets/animations/download.json'),
                              //  assets/animations/download.json
                              // child: CircularProgressIndicator(
                              //   backgroundColor: kBackgroundColor,
                              //   color: kPrimaryColor,
                              // ),
                            );
                          }
                        }),
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
