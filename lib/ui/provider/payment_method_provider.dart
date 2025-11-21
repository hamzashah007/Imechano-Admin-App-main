import 'package:imechano_admin/styling/config.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class PaymentMethodApi {
  static Future<bool> addPaymentMethod(
      String jobCardId, String staffId, String paymentChoice) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.paymentmethod);
      int? paymentMethod;
      switch (paymentChoice) {
        case 'Cash':
          paymentMethod = 1;
          break;
        case 'POS':
          paymentMethod = 2;
          break;
        case 'Online Payment':
          paymentMethod = 3;
          break;
      }
      dynamic postData = {
        'job_card_id': jobCardId,
        'staff_id': staffId,
        'payment_method': paymentMethod!,
        'delivery_charges': '',
        'sub_total': '',
        'status': 3
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        log('Inside if');
        responseJson = json.decode(response.body);
        log(responseJson.toString());
        if (responseJson['data']['staff_id'] != null &&
            responseJson['data']['staff_id'] != null) {
          return true;
        } else {
          return false;
        }
      } else {
        log('Inside else');
        log(responseJson.toString());
        return false;
      }
    } catch (exception) {
      log('exception---- $exception');
      return false;
    }
  }
}
