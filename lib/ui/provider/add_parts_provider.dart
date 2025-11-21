import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/add_parts_model.dart';

class AddPartsDataAPi {
  Future<AddPartesModel?> onAddPartsDataApi(
    String partNumber,
    String partType,
    String partDesc,
    String qty,
    String estCost,
    String total,
    String jobNumber,
  ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.addparts);

      dynamic postData = {
        'part_number': partNumber,
        'part_type': partType,
        'part_desc': partDesc,
        'qty': qty,
        'est_cost': estCost,
        'total': total,
        'job_number': jobNumber,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return AddPartesModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final addPartsDataAPi = AddPartsDataAPi();
