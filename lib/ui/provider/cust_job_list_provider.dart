import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/cust_job_list_model.dart';

class CustomerJobListAPI {
  // ignore: non_constant_identifier_names
  Future<CustomerJobListModel?> onCustomerJobListApi(String job_number) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.customer_job_detail);

      dynamic postData = {
        'job_number': job_number,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print("Job card detail response");
      print(response.body);
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CustomerJobListModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return CustomerJobListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
