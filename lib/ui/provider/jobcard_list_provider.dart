import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/jobcard_list_model.dart';

class JobcardListApi {
  Future<JobcardlistModel?> onJobcardListApi({String? garageId}) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.job_list);
      log('Got garage id: $garageId');
      dynamic postData = {'garageId': garageId};
      final response =
          await http.post(strURL, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);

        return JobcardlistModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final jobcardListApi = JobcardListApi();
