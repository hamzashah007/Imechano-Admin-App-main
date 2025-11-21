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
import 'package:imechano_admin/ui/bottombar/job_card_24.dart';

class Utils {
  static void handleNotificationNavigation(
      [RemoteMessage? message, String? title, String? jobNo]) {
    // Log the full notification payload
    log('[Notification Payload] message: ${message?.data} title: $title jobNo: $jobNo');

    String? str = title ?? message?.data.toString();
    log('Got str in handle notification: $str');

    // Try to extract job number from multiple possible sources
    String? jobNumber;
    if (jobNo != null && jobNo.isNotEmpty) {
      jobNumber = jobNo;
    } else if (message?.data['job_number'] != null) {
      jobNumber = message?.data['job_number'].toString();
    } else if (message?.data['jobNo'] != null) {
      jobNumber = message?.data['jobNo'].toString();
    }
    log('Extracted jobNumber: $jobNumber');

    log('GOT DATA FROM APPROVE JOB CARD ${message?.data}, JOB NO:  $jobNumber');
    if (Get.context != null) {
      Provider.of<NotificationCountProvider>(Get.context!, listen: false)
          .setNotifications();
    } else {
      log('[ERROR] Get.context is null, cannot update notifications!');
    }
    if ((str != null &&
        (str.contains('New Booking') ||
            str.contains('Emergency Booking') ||
            str.contains('Car Checkup Booking') ||
            str.contains('Quick Service Booking') ||
            str.contains('Upholstery Booking') ||
            str.contains('Car Detailing Booking')))) {
      Get.offAll(() => PickupSchedulePage());
    } else if (str != null &&
        (str.contains('Job Card Accepted') ||
            str.contains('User has Approved a Job Card') ||
            str.contains('Job Card Approved'))) {
      Get.offAll(() => JobCardTwentyfour());
    } else if (str != null &&
        (str.contains('Approve Job Card') ||
            str.contains('Confirm Delivery Rejected'))) {
      if (jobNumber != null && jobNumber.isNotEmpty) {
        Get.to(() => MyJobCard(job_number: jobNumber));
      } else {
        log('[ERROR] Job number missing, cannot navigate to MyJobCard');
      }
    } else if (str != null &&
        (str.contains('Payment Confirmation') ||
            str.contains('Pickup Confirmation Accept') ||
            str.contains('Confirm Delivery Completed') ||
            str.contains('Cancel Job Card') ||
            str.contains('Pickup Confirmation Rejected') ||
            str.contains('Delivery Scheduled'))) {
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
