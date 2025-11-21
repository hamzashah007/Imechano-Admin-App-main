import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano_admin/ui/bottombar/appointment_page.dart';
import 'package:imechano_admin/ui/provider/notification_count_provider.dart';
import 'package:imechano_admin/ui/screens/drawer/my_job.dart';
import 'package:provider/provider.dart';

import '../ui/bottombar/pickup_schedule_page.dart';

class Utils {
  static void handleNotificationNavigation(
      [RemoteMessage? message, String? title, String? jobNo]) {
    String? str = title ?? message!.data.toString();

    log('Got str in handle notification: $str');
    log('GOT DATA FROM APPROVE JOB CARD ${message?.data}, JOB NO:  ${message?.data['job_number']}');
    if (Get.context != null) {
      Provider.of<NotificationCountProvider>(Get.context!, listen: false)
          .setNotifications();
    } else {
      log('[ERROR] Get.context is null, cannot update notifications!');
    }
    if ((str.contains('New Booking') ||
        str.contains('Emergency Booking') ||
        str.contains('Car Checkup Booking') ||
        str.contains('Quick Service Booking') ||
        str.contains('Upholstery Booking') ||
        str.contains('Car Detailing Booking'))) {
      Get.offAll(() => PickupSchedulePage());
    } else if (str.contains('Approve Job Card') ||
        str.contains('Confirm Delivery Rejected')) {
      String? jobNumber = jobNo ?? message!.data['job_number'];
      if (jobNumber != null) {
        Get.to(() => MyJobCard(job_number: jobNumber));
      }
    } else if (str.contains('Payment Confirmation') ||
        str.contains('Pickup Confirmation Accept') ||
        str.contains('Confirm Delivery Completed') ||
        str.contains('Cancel Job Card') ||
        str.contains('Pickup Confirmation Rejected') ||
        str.contains('Delivery Scheduled')) {
      Get.offAll(() => AppointmentPage());
    }
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
