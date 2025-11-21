import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/incoming_bookings_details_model.dart';

class IncomingBookingsDetailsApi {
  Future<IncomingBookingsDetailsModel?> onIncomingBookingsDetailsApi(
      String id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.incomingbookingsdetails);

      dynamic postData = {
        'id': id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        // AppData.StatusCode = id;
        return IncomingBookingsDetailsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final incomingBookingsDetailsApi = IncomingBookingsDetailsApi();
