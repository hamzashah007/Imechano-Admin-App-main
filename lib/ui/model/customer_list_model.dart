class CustomerListModel {
  String? code;
  String? message;
  List<Data>? data;

  CustomerListModel({this.code, this.message, this.data});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
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
  String? carId;
  String? customerId;
  String? status;
  String? bookingId;
  String? plateNumber;
  String? carsUnderCustomer;
  String? customerName;
  String? mobileNumber;
  String? grageName;

  Data(
      {this.id,
      this.carId,
      this.customerId,
      this.status,
      this.bookingId,
      this.plateNumber,
      this.carsUnderCustomer,
      this.customerName,
      this.mobileNumber,
      this.grageName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    carId = json['car_id'];
    customerId = json['customer_id'];
    status = json['status'];
    bookingId = json['booking_id'];
    plateNumber = json['plate_number'] ?? '';
    carsUnderCustomer = json['cars_under_customer'] ?? '';
    customerName = json['customer_name'];
    mobileNumber = json['mobile_number'];
    grageName = json['grage_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['booking_id'] = this.bookingId;
    data['plate_number'] = this.plateNumber;
    data['cars_under_customer'] = this.carsUnderCustomer;
    data['customer_name'] = this.customerName;
    data['mobile_number'] = this.mobileNumber;
    data['grage_name'] = this.grageName;
    return data;
  }
}
