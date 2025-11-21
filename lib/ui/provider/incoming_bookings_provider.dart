import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/incoming_bookings_model.dart';

class IncomingBookingsApi {
  Future<IncomingBookingsModel?> onIncomingBookingsApi(
      String status, String fromdate, String todate) async {
    log('Calling api');
    try {
      final uri = Uri.parse(Config.apiurl + Config.incomingbookings);

      dynamic postData = {
        'status': status,
        'from_date': fromdate,
        'to_date': todate,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        log('Inside if');
        responseJson = json.decode(response.body);
        log("Status: " +
            status +
            " From Date: " +
            fromdate +
            " To Date: " +
            todate);
        print("~~~~~~~~~~~~~~Incoming Booking start~~~~~~~~~~~~~~~");
        print(responseJson);
        print("~~~~~~~~~~~~~~Incoming Booking end~~~~~~~~~~~~~~~");
        AppData.StatusCode = status;
        return IncomingBookingsModel.fromJson(responseJson);
      } else {
        log('Inside else');
        return null;
      }
    } catch (exception) {
      log('exception---- $exception');
      return null;
    }
  }
}

final incomingBookingsApi = IncomingBookingsApi();
