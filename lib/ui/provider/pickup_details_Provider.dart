import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/pickup_details_model.dart';

class PickupDetailsAPI {
  // ignore: non_constant_identifier_names
  Future<PickupdetailsModel?> onPickupdetailsApi(String pickup_id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.pickup_details);

      dynamic postData = {
        'pickup_id': pickup_id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return PickupdetailsModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return PickupdetailsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
