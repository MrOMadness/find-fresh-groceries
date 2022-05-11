// Style page
import 'package:flutter/material.dart';

class Styles {
  static const String robotoFont = 'roboto';
  static const int greenBotNav = 0xff5BB98B;
  static const int inactiveGrey = 0xff5BB98B;
  static const int yellow = 0xffFCAF05;
  static const int greenMain = 0xff1EA050;
  static const int backgroundGrey = 0x75EFF3F6;
  static const int borderGrey = 0xffEFF3F6;
  static const int lowBlack = 0xb5000000;

  static const TextStyle roboto10Bold = TextStyle(
    color: Colors.black,
    fontFamily: robotoFont,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );
  static const TextStyle roboto14Bold = TextStyle(
    color: Colors.black,
    fontFamily: robotoFont,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  static const TextStyle roboto20BoldWhite = TextStyle(
    color: Colors.white,
    fontFamily: robotoFont,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static const TextStyle roboto24Yellow = TextStyle(
    color: Color(yellow),
    fontFamily: robotoFont,
    fontSize: 24,
  );
  static const TextStyle roboto24Green = TextStyle(
    color: Color(greenMain),
    fontFamily: robotoFont,
    fontSize: 24,
  );
  static const TextStyle roboto14MediumLowBlack = TextStyle(
    color: Color(lowBlack),
    fontFamily: robotoFont,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle roboto16BoldLowBlack = TextStyle(
    color: Color(lowBlack),
    fontFamily: robotoFont,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
}
