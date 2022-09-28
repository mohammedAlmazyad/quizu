import 'package:flutter/material.dart';

//double
const kRadiusSquare = 4.5;
const kRadiusCircle = 18.0;

//decoration
const kBorderRadius = BorderRadius.all(Radius.circular(10));
const kBorderRadiusSmall = BorderRadius.all(Radius.circular(5));
const kBorderRadiusLarge = BorderRadius.all(Radius.circular(20));
const kBoxShadow = [BoxShadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 3))];
const kBoxShadowAround = [BoxShadow(blurRadius: 5, color: Colors.black26)];
const kCardHeight = 40.0;
const kContainerDecoration = BoxDecoration(color: kBackgroundColor, boxShadow: kBoxShadow, borderRadius: kBorderRadius);

//colors
const kPrimaryColor = Color(0xff2FBCB3);
const kBackgroundColor = Color(0xFFF5FAFF);
const kTextColor = Color(0xFF001833);
const kShadowColor = Color(0x22343434);
const kFextFieldColor = Color(0xffEDEEF2);
const kTextWhite = Color(0xffF5FAFF);
// TextStyles
// s = size , w = weight , c = color
const ks24w5ct = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, color: kTextColor, fontFamily: 'Poppins');
const ks18w5cpr = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: kPrimaryColor, fontFamily: 'Poppins');
const ks16w4ctf = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: kTextWhite, fontFamily: 'Poppins');
const ks16w5ct = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: kTextColor, fontFamily: 'Poppins');
const ks16w5cpr = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: kPrimaryColor, fontFamily: 'Poppins');
const ks16w6cw = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: kTextWhite, fontFamily: 'Poppins');
const ks14w4ct = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: kTextColor, fontFamily: 'Poppins');
const ks14w5ct = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: kTextColor, fontFamily: 'Poppins');
const ks14w5cw = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: kTextWhite, fontFamily: 'Poppins');
const ks14wBcpr = TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kPrimaryColor, fontFamily: 'Poppins');
const ks14w4cpr = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: kPrimaryColor, fontFamily: 'Poppins');
const ks12w6cpr = TextStyle(fontSize: 12.0, color: kPrimaryColor, fontWeight: FontWeight.w600, fontFamily: 'Poppins');
const ks12w5cpr = TextStyle(fontSize: 12.0, color: kTextColor, fontWeight: FontWeight.w500, fontFamily: 'Poppins');
const ks12w5ct = TextStyle(fontSize: 12.0, color: kTextColor, fontWeight: FontWeight.w500, fontFamily: 'Poppins');
const ks16w5cr = TextStyle(fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.w500, fontFamily: 'Poppins');

// const ks24w5ct = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, color: kTextColor);

// const kSubTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kGrey1);
const kClickableTextStyle = TextStyle(fontSize: 14, color: Color(0xFF2C9198), fontWeight: FontWeight.w600);
const kAlertTS = TextStyle(fontSize: 15);
const kMidTitleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

// Icons
const kOkoulLogo = 'assets/images/OkoulLogo.png';
const kloadingAnimation = "assets/animations/loading_animation.json";
