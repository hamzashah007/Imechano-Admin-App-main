import 'package:flutter/material.dart';
import 'package:imechano_admin/styling/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget title;
  final double width;
  final Color bgColor;
  final Color borderColor;
  final Function callBackFunction;

  const CustomButton({
    Key? key,
    required this.title,
    required this.width,
    required this.callBackFunction,
    required this.bgColor,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      width: MediaQuery.of(context).size.width * width,
      child: ElevatedButton(
        onPressed: () {
          callBackFunction();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: transparent,
          elevation: 0,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: title,
      ),
    );
  }
}
