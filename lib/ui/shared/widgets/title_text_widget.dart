import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  final String text;
  const TitleTextWidget({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(children: [
      Text(title,
          style: TextStyle(
              fontFamily: "Poppins3",
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 11)),
      SizedBox(width: size.width * 0.02),
      Text(
        text,
        style: TextStyle(
            fontFamily: "Poppins3",
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 11),
      )
    ]);
  }
}
