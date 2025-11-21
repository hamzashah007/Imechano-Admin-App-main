import 'dart:convert';
import 'dart:developer';

import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/booking_details_model.dart';
import 'package:http/http.dart' as http;

class ViewDetailsApi {
  static Future<BookingDetailsModel>? viewBookingDetails(
      String bookingId) async {
    try {
      final strURL =
          Uri.parse('${Config.apiurl}${Config.viewDetails}$bookingId');
      final response =
          await http.get(strURL, headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        log('Got response: $responseJson');
        if (responseJson['code'] == 1) {
          log('Inside if');
          return BookingDetailsModel.fromJson(responseJson['data']);
        } else {
          log('Inside else');
          return BookingDetailsModel();
        }
      } else {
        log('Status code: ${response.statusCode}');
        log('${response.body}');
        return BookingDetailsModel();
      }
    } catch (exception) {
      log('exception---- $exception');
      return BookingDetailsModel();
    }
  }
}
