class GarageDetailsModel {
  int? code;
  String? message;
  Data? data;

  GarageDetailsModel({this.code, this.message, this.data});

  GarageDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? garageImage;
  String? garageId;
  String? crNo;
  String? crImage;
  String? garageName;
  String? garageProfile;
  String? email;
  String? mobileNumber;
  String? address;
  String? longitude;
  String? latitude;
  String? city;

  Data(
      {this.id,
      this.garageImage,
      this.garageId,
      this.crNo,
      this.crImage,
      this.garageName,
      this.garageProfile,
      this.email,
      this.mobileNumber,
      this.address,
      this.longitude,
      this.latitude,
      this.city});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    garageImage = json['garage_image'] ?? "";
    garageId = json['garage_id'] ?? "";
    crNo = json['cr_no'] ?? "";
    crImage = json['cr_image'] ?? "";
    garageName = json['garage_name'] ?? "";
    garageProfile = json['garage_profile'] ?? "";
    email = json['email'] ?? "";
    mobileNumber = json['mobile_number'] ?? "";
    address = json['address'] ?? "";
    longitude = json['longitude'] ?? "";
    latitude = json['latitude'] ?? "";
    city = json['city'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['garage_image'] = this.garageImage;
    data['garage_id'] = this.garageId;
    data['cr_no'] = this.crNo;
    data['cr_image'] = this.crImage;
    data['garage_name'] = this.garageName;
    data['garage_profile'] = this.garageProfile;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['city'] = this.city;
    return data;
  }
}
