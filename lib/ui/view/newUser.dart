// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:quizu/core/api.dart';
import 'package:quizu/ui/view/otp.dart';

import '../../app.dart';
import '../../core/constances/decorations.dart';
import '../../core/providers/userProvider.dart';
import '../widgets/appButton.dart';
import 'package:http/http.dart';

import '../widgets/snackBar.dart';

class NewUserView extends StatefulWidget {
  NewUserView({
    Key key,
  }) : super(key: key);

  @override
  State<NewUserView> createState() => _NewUserViewState();
}

class _NewUserViewState extends State<NewUserView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                        'It looks like you are new here',
                        style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'what should I call you ?',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      title: Text('Name'),
                      subtitle: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'Mohammed A-mazyad',
                        ),
                        onChanged: (value) {
                          user.setUserName(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  text: 'Submit',
                  function: () async {
                    if (user.userName != null && user.userName != '') {
                      Response response = await API().setName(
                        user.userName,
                      );
                      if (response.ok) {
                        showActionSnackBar(context, 'Done!');
                        Navigator.pushNamedAndRemoveUntil(context, '/Route', (route) => false);
                      } else {
                        var decoded = json.decode(response.body);
                        showActionSnackBar(context, decoded['message']);
                      }
                    } else {
                      showActionSnackBar(context, 'Enter you name');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
