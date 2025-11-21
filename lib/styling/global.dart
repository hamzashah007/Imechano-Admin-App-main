// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// Function to handle image selection and upload
Future<XFile> compressImage(XFile file) async {
  try {
    final fileSize = await file.length();

    final sizeInMB = fileSize / (1024 * 1024);
    if (sizeInMB < 1) {
      return file;
    }
    final dir = await path_provider.getTemporaryDirectory();
    String imagePath = generateRandomKey();
    final targetPath = '${dir.absolute.path}/$imagePath.jpg';
    // converting original image to compress it
    XFile? result = await FlutterImageCompress.compressAndGetFile(
        file.path, targetPath,
        quality: 90);
    final originalSize =
        await File(file.path).length(); // Get original file size
    final compressedSize =
        result == null ? 0 : await File(result.path).length();

    // Convert sizes to megabytes
    final originalSizeInMB = originalSize / (1024 * 1024);
    final compressedSizeInMB = compressedSize / (1024 * 1024);

    log('Original size: ${originalSizeInMB.toStringAsFixed(2)} MB, Compressed size: ${compressedSizeInMB.toStringAsFixed(2)} MB');

    return result != null ? result : file;
  } catch (e) {
    log(e.toString());
    return file;
  }
}

String generateRandomKey() {
  const chars = 'aBcDeFgHiJkLmNoPqRsTuVwXyZ0123456789';
  final random = math.Random.secure();
  final codeUnits = List.generate(
    10,
    (index) => chars.codeUnitAt(random.nextInt(chars.length)),
  );
  return String.fromCharCodes(codeUnits);
}

class Loader {
  void showLoader(BuildContext context) {
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pink),
                  ),
                ),
              )
            ],
          ));
        });
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    String message) {
  return ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ),
  );
}

Widget textTitel(title) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: "Poppins3",
        color: Colors.grey,
        fontWeight: FontWeight.w600,
        fontSize: 11.sp),
  );
}

Widget textAns(ans) {
  return Text(
    ans ?? '',
    style: TextStyle(
        fontFamily: "Poppins3",
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 11.sp),
  );
}

void showpopDialog(BuildContext context, String title, String body) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300], // optional background color
              foregroundColor: Colors.black, // text color
            ),
            child: const Text('OK'),
            onPressed: () {
              print('Tapped OK in dialog');
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String formatDateString(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String formattedDate = DateFormat("dd/MM/yyyy").format(date);
  return formattedDate;
}

class DataPicker {
  void data(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
  }
}
