class CustomerDetailsModel {
  int? code;
  String? message;
  Data? data;

  CustomerDetailsModel({this.code, this.message, this.data});

  CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? carId;
  String? bookingId;
  String? customerId;
  String? timeDate;
  String? categoryId;
  String? itemId;
  CarDetails? carDetails;
  CustomerDetails? customerDetails;
  String? serviceName;
  List<PartsDetail>? partsDetail;

  Data(
      {this.id,
      this.carId,
      this.bookingId,
      this.customerId,
      this.timeDate,
      this.categoryId,
      this.itemId,
      this.carDetails,
      this.customerDetails,
      this.serviceName,
      this.partsDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['car_id'].toString();
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
    timeDate = json['time_date'];
    categoryId = json['category_id'];
    itemId = json['item_id'];
    carDetails = json['car_details'] != null
        ? new CarDetails.fromJson(json['car_details'])
        : null;
    customerDetails = json['customer_details'] != null
        ? new CustomerDetails.fromJson(json['customer_details'])
        : null;
    serviceName = json['service_name'];
    if (json['parts_detail'] != null) {
      partsDetail = <PartsDetail>[];
      json['parts_detail'].forEach((v) {
        partsDetail!.add(new PartsDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['time_date'] = this.timeDate;
    data['category_id'] = this.categoryId;
    data['item_id'] = this.itemId;
    if (this.carDetails != null) {
      data['car_details'] = this.carDetails!.toJson();
    }
    if (this.customerDetails != null) {
      data['customer_details'] = this.customerDetails!.toJson();
    }
    data['service_name'] = this.serviceName;
    if (this.partsDetail != null) {
      data['parts_detail'] = this.partsDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarDetails {
  String? model;
  String? modelYear;
  String? mileage;
  String? cylinder;

  CarDetails({this.model, this.modelYear, this.mileage, this.cylinder});

  CarDetails.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    modelYear = json['model_year'];
    mileage = json['mileage'];
    cylinder = json['cylinder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['model_year'] = this.modelYear;
    data['mileage'] = this.mileage;
    data['cylinder'] = this.cylinder;
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? gender;
  Null? address;

  CustomerDetails(
      {this.id,
      this.name,
      this.email,
      this.mobileNumber,
      this.gender,
      this.address});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['address'] = this.address;
    return data;
  }
}

class PartsDetail {
  int? id;
  String? item;
  String? price;
  String? description;

  PartsDetail({this.id, this.item, this.price, this.description});

  PartsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
