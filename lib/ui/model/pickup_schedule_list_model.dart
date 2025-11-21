class PickupScheduleListModel {
  String? code;
  String? message;
  List<Data>? data;

  PickupScheduleListModel({this.code, this.message, this.data});

  PickupScheduleListModel.fromJson(Map<String, dynamic> json) {
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
  String? carId;
  String? customerId;
  String? timeDate;
  String? carsDetails;
  UserDetails? userDetails;

  Data(
      {this.id,
      this.bookingId,
      this.carId,
      this.customerId,
      this.timeDate,
      this.carsDetails,
      this.userDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    bookingId = json['booking_id'];
    carId = json['car_id'];
    customerId = json['customer_id'];
    timeDate = json['time_date'];
    carsDetails = json['cars_details'].toString();
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['time_date'] = this.timeDate;
    data['cars_details'] = this.carsDetails;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? address;

  UserDetails(
      {this.id, this.name, this.email, this.mobileNumber, this.address});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    address = json['address'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    return data;
  }
}
