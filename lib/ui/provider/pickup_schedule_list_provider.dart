import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/pickup_schedule_list_model.dart';

class PickupScheduleListApi {
  Future<PickupScheduleListModel?> onPickupScheduleListApi(
      String userId) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.pickup_schedule_list);

      dynamic postData = {
        'user_id': userId,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return PickupScheduleListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final pickupScheduleListApi = PickupScheduleListApi();
