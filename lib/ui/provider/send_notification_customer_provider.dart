// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/send_notification_customer.dart';

class SendNotificationCustomerApi {
  // ignore: non_constant_identifier_names
  Future<dynamic> onSendNotificationCustomerApi(
    String booking_id,
    String title,
    String message,
  ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.send_customer);

      dynamic postData = {
        'booking_id': booking_id,
        'title': title,
        'message': message,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      log(response.toString());
      print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return SendNotificationCustomerModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return SendNotificationCustomerModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
