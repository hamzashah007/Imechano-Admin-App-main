import 'dart:developer';

class CustomerJobListModel {
  String? code;
  String? message;
  List<Data>? data;

  CustomerJobListModel({this.code, this.message, this.data});

  CustomerJobListModel.fromJson(Map<String, dynamic> json) {
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
  String? garageName;
  String? jobNumber;
  String? jobDate;
  String? customerName;
  String? customerContactNo;
  String? carRegNumber;
  String? year;
  String? mileage;
  String? dateTime;
  String? carMake;
  String? carModel;
  String? vinNumber;
  String? total;
  String? status;
  String? delivery_time;
  String? inoive_image1;
  String? car_imagge;
  String? inoive_image2;
  String? inoive_image3;
  String? subcategoryName;
  List<Items>? items;

  Data(
      {this.id,
      this.bookingId,
      this.garageName,
      this.jobNumber,
      this.jobDate,
      this.customerName,
      this.customerContactNo,
      this.carRegNumber,
      this.year,
      this.mileage,
      this.dateTime,
      this.carMake,
      this.carModel,
      this.vinNumber,
      this.status,
      this.total,
      this.subcategoryName,
      this.delivery_time,
      this.inoive_image1,
      this.inoive_image2,
      this.inoive_image3,
      this.car_imagge,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    garageName = json['garage_name'];
    bookingId = json['booking_id'];
    jobNumber = json['job_number'];
    jobDate = json['job_date'] ?? "null";
    customerName = json['customer_name'] ?? "null";
    customerContactNo = json['customer_contact_no'] ?? "null";
    carRegNumber = json['car_reg_number'] ?? "null";
    year = json['year'] ?? "null";
    mileage = json['mileage'] ?? "null";
    dateTime = json['date_time'] ?? "null";
    carMake = json['car_make'] ?? "null";
    carModel = json['car_model'] ?? "null";
    vinNumber = json['vin_number'] ?? "null";
    status = json['status'] ?? '';
    log('GOT STATUS: $status');
    total = json['total'] ?? "null";
    delivery_time = json['delivery_time'] ?? "null";
    inoive_image1 = json['inoive_image1'] ?? "";
    inoive_image2 = json['inoive_image2'] ?? "";
    inoive_image3 = json['inoive_image3'] ?? "";
    car_imagge = json['car_imagge'] ?? "";

    subcategoryName = json['subcategory_name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['garage_name'] = this.garageName;
    data['booking_id'] = this.bookingId;
    data['job_number'] = this.jobNumber;
    data['job_date'] = this.jobDate;
    data['customer_name'] = this.customerName;
    data['customer_contact_no'] = this.customerContactNo;
    data['car_reg_number'] = this.carRegNumber;
    data['year'] = this.year;
    data['mileage'] = this.mileage;
    data['date_time'] = this.dateTime;
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['status'] = this.status;
    data['vin_number'] = this.vinNumber;
    data['total'] = this.total;
    data['subcategory_name'] = this.subcategoryName;
    data['delivery_time'] = this.delivery_time;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? item;
  String? price;
  String? description;

  Items({this.id, this.item, this.price, this.description});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    item = json['item'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
