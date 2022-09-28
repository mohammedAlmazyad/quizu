// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizu/ui/view/otp.dart';
import 'package:quizu/ui/widgets/dialog.dart';

import '../../app.dart';
import '../../core/constances/decorations.dart';
import '../../core/providers/userProvider.dart';
import '../widgets/appButton.dart';
import 'package:phone_number/phone_number.dart';

import '../widgets/snackBar.dart';

class LoginView extends StatefulWidget {
  bool closeOnAuth;

  LoginView({Key key, this.closeOnAuth}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

bool isValid = false;

class _LoginViewState extends State<LoginView> {
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
                          height: 150,
                          width: 150,
                          child: Lottie.asset('assets/animations/hip-hop-waling-rabbit.json', fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        'QuizU ⏳',
                        style: TextStyle(fontSize: 32, color: Color(0xfff001833), fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Mobile',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    IntlPhoneField(
                      // validator: (phone) async {
                      //   isValid = await PhoneNumberUtil().validate(phone.completeNumber);
                      //   user.setIsValidPhone(isValid);
                      //   if (isValid) {
                      //     return null;
                      //   } else
                      //     return 'false';
                      // },
                      // onSubmitted: (phone) {
                      //   if (user.isValidPhone) {
                      //     Navigator.pushNamedAndRemoveUntil(context, '/Otp', (route) => false);
                      //   } else {
                      //     showActionSnackBar(context, 'Error has occured! please re-type your number :)');
                      //   }
                      // },
                      dropdownTextStyle: ks12w6cpr,
                      invalidNumberMessage: 'Wrong number',
                      decoration: InputDecoration(
                        hintText: '53 555 5555',
                        filled: true,
                        // fillColor: textFieldColor,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 0.5,
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: kCupertinoModalBarrierColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      initialCountryCode: 'SA',
                      onChanged: (phone) async {
                        isValid = await PhoneNumberUtil().validate(phone.completeNumber);
                        print('the ansser is =======-=-=-=-$isValid');
                        user.setIsValidPhone(isValid);
                        user.setUserPhone(phone.completeNumber);
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  text: 'Start',
                  function: () {
                    if (user.isValidPhone) {
                      Navigator.pushNamedAndRemoveUntil(context, '/Otp', (route) => false);
                    } else {
                      showActionSnackBar(context, 'Error has occured! please re-type your number :)');
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
