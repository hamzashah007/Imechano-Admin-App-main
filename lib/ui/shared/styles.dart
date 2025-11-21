import 'package:flutter/material.dart';
import 'package:imechano_admin/styling/colors.dart';

abstract class ThemeText {
  static const TextStyle primaryText =
      TextStyle(color: Colors.black, fontSize: 16);

  static const TextStyle locationText =
      TextStyle(color: Colors.black, fontSize: 14);

  static const TextStyle headingText =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);

  static const TextStyle eventDetailsText =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle deadlineText =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle subtitleText =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300);

  static const TextStyle halaqahCardText = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  static const TextStyle cardBoldText =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle appBarText =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white);

  static const TextStyle boldText =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle btnText =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static const TextStyle userText =
      TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold);
  static const TextStyle cardText =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600);

  static const TextStyle textButton =
      TextStyle(color: logoBlue, fontSize: 16, fontStyle: FontStyle.italic);

  static const TextStyle noteText = TextStyle(
      color: logoBlue,
      fontSize: 16,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);

  static const TextStyle progressHeader = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 40,
      height: 0.5,
      fontWeight: FontWeight.w600);
}
