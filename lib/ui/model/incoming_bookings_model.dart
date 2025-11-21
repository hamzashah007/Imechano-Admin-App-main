import 'package:intl/intl.dart';

class IncomingBookingsModel {
  String? code;
  String? message;
  List<Data>? data;

  IncomingBookingsModel({this.code, this.message, this.data});

  IncomingBookingsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? bookingId;
  String? customerId;
  String? garageId;
  String? appointmentTime;
  String? bookingTime;
  String? carImage;
  String? customerName;
  String? sub_category;
  String? garageProfile;
  String? garageName;

  Data(
      {this.id,
      this.bookingId,
      this.customerId,
      this.garageId,
      this.appointmentTime,
      this.bookingTime,
      this.carImage,
      this.customerName,
      this.sub_category,
      this.garageProfile,
      this.garageName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
    garageId = json['garage_id'].toString();
    appointmentTime = json['time_date'];
    bookingTime = json['created_at'] ?? '';
    DateTime parsedDate = DateTime.parse(bookingTime!).toLocal();
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(parsedDate);
    bookingTime = formattedDate;
    carImage = json['car_image'] ?? '';
    customerName = json['customer_name'] ?? '';
    garageProfile = json['garage_profile'] ?? '';
    garageName = json['garage_name'] ?? 'Not assigned';
    sub_category = json['sub_category_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['garage_id'] = this.garageId;
    data['time_date'] = this.appointmentTime;
    data['createdAt'] = this.bookingTime;
    data['car_image'] = this.carImage;
    data['customer_name'] = this.customerName;
    data['garage_profile'] = this.garageProfile;
    data['garage_name'] = this.garageName;
    return data;
  }
}
