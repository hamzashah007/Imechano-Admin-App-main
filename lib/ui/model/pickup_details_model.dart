class PickupdetailsModel {
  String? code;
  String? message;
  Data? data;

  PickupdetailsModel({this.code, this.message, this.data});

  PickupdetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? status;
  CarDetails? carDetails;
  GarageDetails? garageDetails;
  PickupDetails? pickupDetails;

  Data(
      {this.id,
      this.carId,
      this.bookingId,
      this.customerId,
      this.timeDate,
      this.categoryId,
      this.itemId,
      this.garageId,
      this.status,
      this.carDetails,
      this.garageDetails,
      this.pickupDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    carId = json['car_id'];
    bookingId = json['booking_id'];
    customerId = json['customer_id'];
    timeDate = json['time_date'];
    categoryId = json['category_id'];
    itemId = json['item_id'];
    garageId = json['garage_id'].toString();
    status = json['status'];
    carDetails = json['car_details'] != null
        ? new CarDetails.fromJson(json['car_details'])
        : null;
    garageDetails = json['garage_details'] != null
        ? new GarageDetails.fromJson(json['garage_details'])
        : null;
    pickupDetails = json['pickup_details'] != null
        ? new PickupDetails.fromJson(json['pickup_details'])
        : null;
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
    data['status'] = this.status;
    if (this.carDetails != null) {
      data['car_details'] = this.carDetails!.toJson();
    }
    if (this.garageDetails != null) {
      data['garage_details'] = this.garageDetails!.toJson();
    }
    if (this.pickupDetails != null) {
      data['pickup_details'] = this.pickupDetails!.toJson();
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

class GarageDetails {
  String? id;
  String? garageId;
  String? garageName;
  String? garageProfile;
  String? email;
  String? mobileNumber;
  String? address;
  String? city;

  GarageDetails(
      {this.id,
      this.garageId,
      this.garageName,
      this.garageProfile,
      this.email,
      this.mobileNumber,
      this.address,
      this.city});

  GarageDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    garageId = json['garage_id'];
    garageName = json['garage_name'];
    garageProfile = json['garage_profile'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    address = json['address'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['garage_id'] = this.garageId;
    data['garage_name'] = this.garageName;
    data['garage_profile'] = this.garageProfile;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    return data;
  }
}

class PickupDetails {
  String? id;
  String? name;
  String? email;
  String? address;

  PickupDetails({this.id, this.name, this.email, this.address});

  PickupDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    address = json['address'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }
}
