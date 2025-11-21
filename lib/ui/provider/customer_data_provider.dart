import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/customer_data_model.dart';

class AllCustomerDataApi {
  Future<CustomerDataModel?> onCustomerDataApi(String page) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.customer_Data);

      dynamic postData = {
        'page': page,
      };

      final response = await http.post(
        strURL,
        body: postData,
      );

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CustomerDataModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final allcustomerdataApi = AllCustomerDataApi();
