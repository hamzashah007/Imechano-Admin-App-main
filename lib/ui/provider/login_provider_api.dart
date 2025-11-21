import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/model/data_not_found_modal.dart';
import 'package:imechano_admin/ui/model/login_model.dart';

class LoginApi {
  Future<dynamic> onLoginApi(
      String email, String password, String fcmToken) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.login);

      dynamic postData = {
        'email': email,
        'password': password,
        'firebase_token': fcmToken,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson = json.decode(response.body);
      log('Response from login api: $responseJson');
      if (response.statusCode == 200) {
        return LoginModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        return DataNotFoundModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final loginApi = LoginApi();
