import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/service_delete_model.dart';

class DeleteServiceAPI {
  // ignore: non_constant_identifier_names
  Future<DeleteServiceModel?> onDeleteServiceListApi(String id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.deleteservice);

      dynamic postData = {
        'id': id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return DeleteServiceModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DeleteServiceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
