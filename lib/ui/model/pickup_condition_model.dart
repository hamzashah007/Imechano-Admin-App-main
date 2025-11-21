// class PickupConditionModel {
//   String? code;
//   String? message;
//   Data? data;

//   PickupConditionModel({this.code, this.message, this.data});

//   PickupConditionModel.fromJson(Map<String, dynamic> json) {
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
//   String? label;
//   String? carCondition;
//   String? workNeeded;
//   String? bookingId;
//   String? jobNumber;
//   String? updatedAt;
//   String? createdAt;
//   String? id;

//   Data(
//       {this.label,
//       this.carCondition,
//       this.workNeeded,
//       this.bookingId,
//       this.jobNumber,
//       this.updatedAt,
//       this.createdAt,
//       this.id});

//   Data.fromJson(Map<String, dynamic> json) {
//     label = json['label'];
//     carCondition = json['car_condition'];
//     workNeeded = json['work_needed'];
//     bookingId = json['booking_id'];
//     jobNumber = json['job_number'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'].toString();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['label'] = this.label;
//     data['car_condition'] = this.carCondition;
//     data['work_needed'] = this.workNeeded;
//     data['booking_id'] = this.bookingId;
//     data['job_number'] = this.jobNumber;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }

class PickupConditionModel {
  String? code;
  String? message;
  Data? data;

  PickupConditionModel({this.code, this.message, this.data});

  PickupConditionModel.fromJson(Map<String, dynamic> json) {
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
  String? carImage;
  String? carCondition;
  String? workNeeded;
  String? carId;
  String? customerId;
  String? bookingId;
  String? status;
  String? jobNumber;
  String? updatedAt;
  String? createdAt;
  String? id;

  Data(
      {this.label,
        this.carImage,
      this.carCondition,
      this.workNeeded,
        this.carId,
        this.customerId,
      this.bookingId,
      this.jobNumber,
        this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    carImage = json['car_imagge'];
    carCondition = json['car_condition'];
    workNeeded = json['work_needed'];
    bookingId = json['booking_id'];
    jobNumber = json['job_number'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['car_image'] = this.carImage;
    data['car_condition'] = this.carCondition;
    data['work_needed'] = this.workNeeded;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['booking_id'] = this.bookingId;
    data['job_number'] = this.jobNumber;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
