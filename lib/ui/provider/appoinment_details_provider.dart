import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/appoinment_details_model.dart';

class AppoinmentDetailsAPI {
  // ignore: non_constant_identifier_names
  Future<AppoinmentDetailsModel?> onAppoimentdetailsApi(
      String appoiementId) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.appoiement_details);

      dynamic postData = {
        'appoiement_id': appoiementId,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        responseJson = json.decode(response.body);
        return AppoinmentDetailsModel.fromJson(responseJson);
      // } else if (response.statusCode == 404) {
      //   responseJson = json.decode(response.body);
      //   return AppoinmentDetailsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception----~ $exception');
      return null;
    }
  }
}
