class PickupRequestModel {
  String? code;
  String? message;
  Data? data;

  PickupRequestModel({this.code, this.message, this.data});

  PickupRequestModel.fromJson(Map<String, dynamic> json) {
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
  String? label;
  String? carConditions;
  String? workNeeded;
  String? carId;
  String? customerId;
  String? status;
  String? updatedAt;
  String? createdAt;
  String? id;

  Data(
      {this.label,
      this.carConditions,
      this.workNeeded,
      this.carId,
      this.customerId,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    carConditions = json['car_conditions'];
    workNeeded = json['work_needed'];
    carId = json['car_id'];
    customerId = json['customer_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['car_conditions'] = this.carConditions;
    data['work_needed'] = this.workNeeded;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
