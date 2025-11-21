import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/styling/global.dart';

class RecreateJobCardApi {
  static Future<bool> onRecreateJobCardApi(
      String jobDate,
      String carRegNumber,
      String year,
      String mileage,
      String dateTime,
      String carMake,
      String carModel,
      String customerName,
      String customerContactNo,
      String vinNumber,
      String garageId,
      String bookingId,
      String jobNumber,
      List<XFile?> _selectedImages) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.reactive_jobcard);

      dynamic postData = {
        'job_date': jobDate,
        'date_time': dateTime,
        'garage_id': garageId,
        'booking_id': bookingId,
        'job_number': jobNumber
      };

      var request = http.MultipartRequest('POST', uri);

      // Set the fields in the request
      for (var key in postData.keys) {
        request.fields[key] = postData[key];
      }

      // Add the selected images to the request
      for (var i = 0; i < _selectedImages.length; i++) {
        if (_selectedImages[i] != null) {
          XFile compressedFile = await compressImage(_selectedImages[i]!);

          var multipartFile =
              await http.MultipartFile.fromPath('image$i', compressedFile.path);
          request.files.add(multipartFile);
        }
      }
      log(request.fields.toString());
      var response = await request.send();

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = await response.stream.bytesToString();
        log(responseJson.toString());
        return true;
      } else {
        final errorBody = await response.stream.bytesToString();
        final errorMessage = 'Error ${response.statusCode}: $errorBody';
        log(errorMessage);
        return false;
      }
    } catch (exception) {
      log('exception---- $exception');
      return false;
    }
  }
}
