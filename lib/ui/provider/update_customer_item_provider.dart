import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';

import '../model/update_customer_item_model.dart';

class UpdateCustomerItemApi {
  Future<UpdateCustomerItemModel?> onUpdateCustomerItemApi(String itemId) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.update_customer_item);

      dynamic postData = {
        'id': itemId,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("responseJson");
        print(responseJson);
        return UpdateCustomerItemModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final updateCustomeItemApi = UpdateCustomerItemApi();
