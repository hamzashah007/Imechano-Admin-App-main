import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';

import 'package:imechano_admin/ui/model/customer_details_model.dart';

class AllCustomerDetailsApi {
  Future<CustomerDetailsModel?> onCustomerDetailsApi(String customerId) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.customer_details);
      dynamic postData = {"customer_id": customerId};
      final response =
          await http.post(strURL, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);

        print(responseJson.runtimeType);
        print(responseJson);
        return CustomerDetailsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final allCustomerDetailsApi = AllCustomerDetailsApi();
