// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/cancel_booking_model.dart';
import 'package:imechano_admin/ui/model/data_not_found_modal%20copy.dart';

class CancelCarBookingApi {
  Future<dynamic> onCancelCarBookingApi(String bookingId) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.cancelBooking);

      dynamic postData = {
        'booking_id': bookingId,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CancelBookingModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DataNotFoundModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
