import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';

import 'package:imechano_admin/ui/model/add_services_model.dart';

class AddServiceDataAPi {
  Future<AddServicesModel?> onAddServicesDataApi(String serviceName,
      String serviceDesc, String serviceCost, String jobNumber) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.addservice);
      log('Service cost: $serviceCost');
      dynamic postData = {
        'service_name': serviceName,
        'service_desc': serviceDesc,
        'service_cost': serviceCost,
        'job_number': jobNumber,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AddServicesModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final addServiceDataAPi = AddServiceDataAPi();
