// import 'package:imechano_admin/ui/model/customer_details_model.dart';

// class IncomingBookingsDetailsModel {
//   String? code;
//   String? message;
//   Data? data;

//   IncomingBookingsDetailsModel({this.code, this.message, this.data});

//   IncomingBookingsDetailsModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'].toString();
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? id;
//   String? carId;
//   String? bookingId;
//   String? customerId;
//   String? timeDate;
//   String? categoryId;
//   String? itemId;
//   String? garageId;
//   String? service;
//   List<CarDetails>? carDetails;
//   CustomerDetails? customerDetails;
//   List<PartsDetails>? partsDetails;

//   Data(
//       {this.id,
//       this.carId,
//       this.bookingId,
//       this.customerId,
//       this.timeDate,
//       this.categoryId,
//       this.itemId,
//       this.garageId,
//       this.service,
//       this.carDetails,
//       this.customerDetails,
//       this.partsDetails});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'].toString();
//     carId = json['car_id'].toString();
//     bookingId = json['booking_id'];
//     customerId = json['customer_id'];
//     timeDate = json['time_date'];
//     categoryId = json['category_id'];
//     itemId = json['item_id'];
//     garageId = json['garage_id'];
//     service = json['service'];
//     if (json['car_details'] != null) {
//       carDetails = <CarDetails>[];
//       json['car_details'].forEach((v) {
//         carDetails!.add(new CarDetails.fromJson(v));
//       });
//     }
//     customerDetails = json['customer_details'] != null
//         ? new CustomerDetails.fromJson(json['customer_details'])
//         : null;
//     if (json['parts_details'] != null) {
//       partsDetails = <PartsDetails>[];
//       json['parts_details'].forEach((v) {
//         partsDetails!.add(new PartsDetails.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['car_id'] = this.carId;
//     data['booking_id'] = this.bookingId;
//     data['customer_id'] = this.customerId;
//     data['time_date'] = this.timeDate;
//     data['category_id'] = this.categoryId;
//     data['item_id'] = this.itemId;
//     data['garage_id'] = this.garageId;
//     data['service'] = this.service;
//     if (this.carDetails != null) {
//       data['car_details'] = this.carDetails!.map((v) => v.toJson()).toList();
//     }
//     if (this.customerDetails != null) {
//       data['customer_details'] = this.customerDetails!.toJson();
//     }
//     if (this.partsDetails != null) {
//       data['parts_details'] =
//           this.partsDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CustomerDetails {
//   String? name;
//   String? mobileNumber;
//   String? email;
//   String? address;
//   String? brand;

//   CustomerDetails(
//       {this.name, this.mobileNumber, this.email, this.address, this.brand});

//   CustomerDetails.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     mobileNumber = json['mobile_number'];
//     email = json['email'];
//     address = json['address'];
//     brand = json['brand'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['mobile_number'] = this.mobileNumber;
//     data['email'] = this.email;
//     data['address'] = this.address;
//     data['brand'] = this.brand;
//     return data;
//   }
// }

// class PartsDetails {
//   String? id;
//   String? item;

//   PartsDetails({this.id, this.item});

//   PartsDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'].toString();
//     item = json['item'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['item'] = this.item;
//     return data;
//   }
// }

class IncomingBookingsDetailsModel {
  String? code;
  String? message;
  Data? data;

  IncomingBookingsDetailsModel({this.code, this.message, this.data});

  IncomingBookingsDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
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
  String? id;
  String? carId;
  String? bookingId;
  String? customerId;
  String? timeDate;
  String? categoryId;
  String? itemId;
  String? garageId;
  String? service;
  CarDetails? carDetails;
  CustomerDetails? customerDetails;
  List<PartsDetails>? partsDetails;

  Data(
      {this.id,
      this.carId,
      this.bookingId,
      this.customerId,
      this.timeDate,
      this.categoryId,
      this.itemId,
      this.garageId,
      this.service,
      this.carDetails,
      this.customerDetails,
      this.partsDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    carId = json['car_id'];
    bookingId = json['booking_id'];
    customerId = json['customer_id'];
    timeDate = json['time_date'];
    categoryId = json['category_id'];
    itemId = json['item_id'];
    garageId = json['garage_id'];
    service = json['service'];
    carDetails = json['car_details'] != null
        ? new CarDetails.fromJson(json['car_details'])
        : null;
    customerDetails = json['customer_details'] != null
        ? new CustomerDetails.fromJson(json['customer_details'])
        : null;
    if (json['parts_details'] != null) {
      partsDetails = <PartsDetails>[];
      json['parts_details'].forEach((v) {
        partsDetails!.add(new PartsDetails.fromJson(v));
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
    data['garage_id'] = this.garageId;
    data['service'] = this.service;
    if (this.carDetails != null) {
      data['car_details'] = this.carDetails!.toJson();
    }
    if (this.customerDetails != null) {
      data['customer_details'] = this.customerDetails!.toJson();
    }
    if (this.partsDetails != null) {
      data['parts_details'] =
          this.partsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarDetails {
  String? model;
  String? modelYear;
  String? mileage;
  String? cylinder;
  String? make;

  CarDetails(
      {this.model, this.modelYear, this.mileage, this.cylinder, this.make});

  CarDetails.fromJson(Map<String, dynamic> json) {
    model = json['model'] ?? '';
    modelYear = json['model_year'] ?? '';
    mileage = json['mileage'] ?? '';
    cylinder = json['cylinder'] ?? '';
    make = json['make'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['model_year'] = this.modelYear;
    data['mileage'] = this.mileage;
    data['cylinder'] = this.cylinder;
    data['make'] = this.make;
    return data;
  }
}

class CustomerDetails {
  String? name;
  String? mobileNumber;
  String? email;
  String? address;
  String? brand;

  CustomerDetails(
      {this.name, this.mobileNumber, this.email, this.address, this.brand});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    address = json['address'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['brand'] = this.brand;
    return data;
  }
}

class PartsDetails {
  String? id;
  String? item;

  PartsDetails({this.id, this.item});

  PartsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    return data;
  }
}
