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
  static void handleNotificationNavigation([
    RemoteMessage? message,
    String? title,
    String? jobNo,
    Map<String, dynamic>? localPayload,
  ]) {
    // Unified data extraction
    final data = message?.data ?? localPayload ?? <String, dynamic>{};
    final type =
        (data['type'] ?? data['action'] ?? '').toString().toLowerCase();
    final jobNumber = jobNo ??
        data['job_number']?.toString() ??
        data['booking_id']?.toString() ??
        data['jobNo']?.toString();

    log('[Notification Navigation] type: $type, jobNumber: $jobNumber, title: $title, data: $data');

    if (Get.context != null) {
      Provider.of<NotificationCountProvider>(Get.context!, listen: false)
          .setNotifications();
    } else {
      log('[ERROR] Get.context is null, cannot update notifications!');
    }

    // Type-based navigation
    if (type.isNotEmpty) {
      switch (type) {
        case 'new_booking':
        case 'emergency_booking':
        case 'car_checkup_booking':
        case 'quick_service_booking':
        case 'car_detailing_booking':
          Get.offAll(() => PickupSchedulePage());
          return;
        case 'job_card_approved':
        case 'job_card_ready':
        case 'job_card_completed':
          Get.offAll(() => JobCardTwentyfour());
          return;
        case 'payment_confirmation':
          Get.offAll(() => AppointmentPage());
          return;
        case 'job_card_ready':
        case 'job_card_approved':
        case 'job_card_completed':
          if (jobNumber != null && jobNumber.isNotEmpty) {
            Get.to(() => MyJobCard(job_number: jobNumber));
            return;
          } else {
            log('[ERROR] Job number missing, cannot navigate to MyJobCard');
          }
          return;
        // Add more cases as needed for other types
      }
    }

    // Fallback: string matching if type is missing
    final str = title ?? data['title']?.toString() ?? data.toString();
    if (str.isNotEmpty) {
      if (str.contains('Pickup Confirmation Accept')) {
        Get.offAll(() => AppointmentPage());
        return;
      }
      if (str.contains('Delivery Scheduled')) {
        Get.offAll(() => AppointmentPage());
        return;
      }
      if (str.contains('Confirm Delivery Completed')) {
        Get.offAll(() => AppointmentPage());
        return;
      }
      if (str.contains('Booking') ||
          str.contains('Emergency') ||
          str.contains('Checkup') ||
          str.contains('Quick Service') ||
          str.contains('Detailing')) {
        Get.offAll(() => PickupSchedulePage());
        return;
      }
      if (str.contains('Job Card') ||
          str.contains('Approved') ||
          str.contains('Completed')) {
        Get.offAll(() => JobCardTwentyfour());
        return;
      }
      if (str.contains('Payment')) {
        Get.offAll(() => AppointmentPage());
        return;
      }
      // Add more fallback cases as needed
    }
    log('[INFO] No navigation matched for type or string.');
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
