import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/model/update_job_card_model.dart';

class UpdateJobCardApi {
  Future<UpdateJobCardModel?> onUpdateJobCardApi(
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
      final uri = Uri.parse(Config.apiurl + Config.update_job_card);

      dynamic postData = {
        'job_date': jobDate,
        'car_reg_number': carRegNumber,
        'year': year,
        'mileage': mileage,
        'date_time': dateTime,
        'car_make': carMake,
        'car_model': carModel,
        'customer_name': customerName,
        'customer_contact_no': customerContactNo,
        'vin_number': vinNumber,
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

          // log('Compressed size got back in api: ${compressedSizeInMB.toStringAsFixed(2)} MB');
          var multipartFile =
              await http.MultipartFile.fromPath('image$i', compressedFile.path);
          request.files.add(multipartFile);
        }
      }
      log(request.fields.toString());
      var response = await request.send();

      dynamic responseJson;
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        print("I m good");
        responseJson = await response.stream.bytesToString();
        return UpdateJobCardModel.fromJson(json.decode(responseJson));
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (exception) {
      snackBar('Image size is too large');
      log('Error: $exception');
      return null;
    }
  }
}

final updateJobCardApi = UpdateJobCardApi();
