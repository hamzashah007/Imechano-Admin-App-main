import 'package:flutter/material.dart';
import 'package:imechano_admin/api/notification_api.dart';
import 'package:imechano_admin/ui/model/notification_count_model.dart';

class NotificationCountProvider with ChangeNotifier {
  NotificationCountModel _notifications =
      NotificationCountModel(total: 0, totalRead: 0, totalUnread: 0);

  int get notifications => _notifications.totalUnread!;

  Future<void> setNotifications() async {
    _notifications = await NotificationApi.getNotificationCount();
    notifyListeners();
  }

  void clearNotifications() async {
    _notifications =
        NotificationCountModel(total: 0, totalRead: 0, totalUnread: 0);
  }
}
