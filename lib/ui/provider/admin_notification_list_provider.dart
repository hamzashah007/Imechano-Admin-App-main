import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/admin_notification_list_model.dart';

class AdminNotificationListeApi {
  Future<AdminNotificationListModel?> onAdminNotificationListeApi() async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.notification_list);

      final response = await http.post(strURL, headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AdminNotificationListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final adminNotificationListeApi = AdminNotificationListeApi();
