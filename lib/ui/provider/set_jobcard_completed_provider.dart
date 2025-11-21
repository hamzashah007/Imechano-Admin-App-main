import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/set_jobcard_completed_model.dart';


class SetJobCardCompletedApi {
  Future<SetJobCardCompletedModel?> onSetJobCardCompletedApi(String jobNumber) async {
    try {
       // set_jobcard_completed
      final uri = Uri.parse(Config.apiurl + Config.send_delivery_request);

      dynamic postData = {
        'job_number': jobNumber,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return SetJobCardCompletedModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final setJobCardCompletedApi = SetJobCardCompletedApi();
