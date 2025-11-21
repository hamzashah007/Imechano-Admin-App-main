import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/appoiement_list_model.dart';

class AppointmentListApi {
  Future<AppoiementListModel?> onAppointmentListApi(
      String fromdate, String todate) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.appoiement_List);

      dynamic postData = {
        'from_date': fromdate,
        'to_date': todate,
      };

      final response =
          await http.post(strURL, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        log('Success! Got appointments: $responseJson');
        return AppoiementListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      log('exception---- $exception');
      return null;
    }
  }
}

final appointmentListApi = AppointmentListApi();
