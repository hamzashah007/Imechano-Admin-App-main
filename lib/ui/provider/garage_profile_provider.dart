import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/garage_profile_model.dart';

class GarageProfileApi {
  Future<GarageProfileModel?> onGarageProfileApi() async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.garage_profile);

      final response = await http.post(strURL, headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GarageProfileModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final garageProfileApi = GarageProfileApi();
