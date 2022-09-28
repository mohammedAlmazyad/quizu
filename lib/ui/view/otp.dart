// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:quizu/app.dart';
import 'package:quizu/core/constances/decorations.dart';
import 'package:quizu/ui/view/newUser.dart';

import '../../core/providers/userProvider.dart';
import '../widgets/appButton.dart';
import 'package:http/http.dart' as http;
import '../../core/api.dart';
import '../widgets/progress_dialog.dart';

// ignore: use_key_in_widget_constructors
ProgressDialog pr;

class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({
    Key key,
  }) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() => _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  // String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    pr = ProgressDialog(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'I will not look :)',
                  style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Lottie.asset('assets/animations/jumpy-eyeballs.json')),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: "${user.userPhone}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                      style: const TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      blinkWhenObscuring: true,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          activeFillColor: kBackgroundColor,
                          inactiveFillColor: kBackgroundColor,
                          selectedColor: kBackgroundColor,
                          activeColor: kBackgroundColor,
                          selectedFillColor: kBackgroundColor),
                      cursorColor: Colors.black,
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {},
                      onChanged: (value) {
                        setState(() {
                          user.setOtp(value);
                        });
                      },
                      beforeTextPaste: (text) {
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //  onPressed: () {
              //         formKey.currentState.validate();
              //         // conditions for validating
              //         if (user.otp.length != 4) {
              //           errorController.add(ErrorAnimationType.shake); // Triggering error shake animation
              //           setState(() => hasError = true);
              //         } else {
              //           setState(
              //             () {
              //               hasError = false;
              //               snackBar("OTP Verified!!");
              //             },
              //           );
              //         }
              //       },
              Center(
                child: AppButton(
                  text: 'Start',
                  function: () async {
                    await pr.show();
                    http.Response response = await API().login(user.otp, user.userPhone);
                    var decoded = json.decode(response.body);
                    await pr.hide();
                    if (response.ok && response.body.contains('new')) {
                      // if the user is a new user
                      user.seToken(decoded['token']);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => NewUserView(),
                          ),
                          (route) => false);
                    } else if (response.ok) {
                      // if the user has an Account
                      print(decoded);
                      user.seToken(decoded['token']);
                      user.setUserName(decoded['name']);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => MyApp(),
                          ),
                          (route) => false);
                    } else if (!response.ok) {
                      //TODO: if there is an error in the call

                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
