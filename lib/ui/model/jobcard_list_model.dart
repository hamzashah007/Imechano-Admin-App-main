import 'package:intl/intl.dart';

class JobcardlistModel {
  String? code;
  String? message;
  List<Data>? data;

  JobcardlistModel({this.code, this.message, this.data});

  JobcardlistModel.fromJson(Map<String, dynamic> json) {
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
  String? jobNumber;
  String? customerName;
  String? customerContactNo;
  String? garageId;
  String? garageProfile;
  String? bookingID;
  String? bookingTime;

  Data(
      {this.id,
      this.bookingTime,
      this.jobNumber,
      this.customerName,
      this.customerContactNo,
      this.garageId,
      this.bookingID,
      this.garageProfile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    bookingTime = json['created_at'].toString();
    DateTime parsedDate = DateTime.parse(bookingTime!).toLocal();
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(parsedDate);
    bookingTime = formattedDate;
    bookingID = json['booking_id'];
    jobNumber = json['job_number'] ?? "null";
    customerName = json['customer_name'] ?? "null";
    customerContactNo = json['customer_contact_no'] ?? "null";
    garageId = json['garage_id'] ?? "null";
    garageProfile = json['garage_profile'] ?? "null";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.bookingTime;
    data['id'] = this.id;
    data['job_number'] = this.jobNumber;
    data['customer_name'] = this.customerName;
    data['customer_contact_no'] = this.customerContactNo;
    data['garage_id'] = this.garageId;
    data['garage_profile'] = this.garageProfile;
    data['booking_id'] = this.bookingID;

    return data;
  }
}
