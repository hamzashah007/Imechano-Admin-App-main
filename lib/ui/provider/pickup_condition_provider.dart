import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/pickup_condition_model.dart';

class PickupConditionApi {
  Future<PickupConditionModel?> onPickupConditionApi(
      String label,
      String carcondition,
      String workneeded,
      String bookingid,
      String carimage) async {
    print("PickupConditionApi");
    try {
      print(label);
      print(carcondition);
      print(workneeded);
      print(bookingid);
      print(carimage);

      final uri = Uri.parse(Config.apiurl + Config.pickup_condition);
      print("B");
      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      if (carimage.isNotEmpty) {
        request.fields.addAll({
          'label': label,
          'car_condition': carcondition,
          'work_needed': workneeded,
          'booking_id': bookingid
        });
      } else {
        request.fields.addAll({
          'label': label,
          'car_condition': carcondition,
          'work_needed': workneeded,
          'booking_id': bookingid,
          'car_image': carimage
        });
      }

      if (carimage.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'car_image',
          carimage,
        ));
      }

      Map<String, String> headers = {'content-Type': 'application/json'};
      request.headers.addAll(headers);

      final http.Response response = await http.Response.fromStream(
        await request.send(),
      );

      dynamic responseJson;
      print(responseJson);
      if (response.statusCode == 200) {
        print("PickupConditionApi status code 200");
        responseJson = json.decode(response.body);
        print(responseJson);
        return PickupConditionModel.fromJson(responseJson);
      } else {
        print("PickupConditionApi status code null");
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final pickupConditionApi = PickupConditionApi();
