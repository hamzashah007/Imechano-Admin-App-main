// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final String imagePath;
  final bool isSuffix;
  final IconData icon;
  final bool readOnly;
  final bool ObscureText;
  final Color fillColor;
  final TextEditingController controller;
  final dynamic validationform;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  const CustomForm({
    Key? key,
    this.hintText = '',
    required this.imagePath,
    this.isSuffix = false,
    this.icon = Icons.visibility,
    this.readOnly = false,
    this.ObscureText = false,
    required this.controller,
    required this.validationform,
    required this.fillColor,
    this.keyboardType = TextInputType.text,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: validationform,
        readOnly: readOnly,
        controller: controller,
        obscureText: ObscureText,
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(imagePath, height: 18),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: 'Poppins3'),
            prefixIconConstraints: BoxConstraints(minWidth: 40),
            suffixIcon: isSuffix
                ? Icon(
                    icon,
                    color: Colors.grey,
                  )
                : null),
      ),
    );
  }
}
