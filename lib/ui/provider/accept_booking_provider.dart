import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/accept_booking_model.dart';

class AcceptBookingApi {
  Future<AcceptBookingModel?> onAcceptBookingApi(
      String bookingId, String delieveryCharges, String garageId) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.acceptbooking);

      dynamic postData = {
        'booking_id': bookingId,
        'delievery_charges': delieveryCharges,
        'garage_id': garageId
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AcceptBookingModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final acceptBookingApi = AcceptBookingApi();
