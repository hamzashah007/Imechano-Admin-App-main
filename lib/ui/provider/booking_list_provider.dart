// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/booking_details_model.dart';
import 'package:imechano_admin/ui/model/data_not_found_modal.dart';

class BookingListApi {
  Future<dynamic> onBookingListApi(
      String customer_id,
      String status,
      String search,
      String start_date,
      String end_date,
      String category) async {
    try {
      log('Cust ID: $customer_id');
      log('Status: $status');

      final uri = Uri.parse(Config.apiurl + Config.bookinglist);

      dynamic postData = {
        'customer_id': customer_id,
        'status': status,
        'search': search,
        'start_date': start_date,
        'end_date': end_date,
        'category': category
      };
      print(postData.toString());
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(responseJson.toString());
        return BookingDetailsModel.fromJson(responseJson);
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
