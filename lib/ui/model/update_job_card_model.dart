// class UpdateJobCardModel {
//   String? code;
//   String? message;
//   List<Data>? data;

//   UpdateJobCardModel({this.code, this.message, this.data});

//   UpdateJobCardModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'].toString();
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? id;
//   String? label;
//   String? carImagge;
//   String? carCondition;
//   String? workNeeded;
//   String? jobNumber;
//   String? jobDate;
//   String? carRegNumber;
//   String? year;
//   String? mileage;
//   String? dateTime;
//   String? carMake;
//   String? carModel;
//   String? customerName;
//   String? customerContactNo;
//   String? vinNumber;
//   String? garageId;
//   String? bookingId;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;

//   Data(
//       {this.id,
//       this.label,
//       this.carImagge,
//       this.carCondition,
//       this.workNeeded,
//       this.jobNumber,
//       this.jobDate,
//       this.carRegNumber,
//       this.year,
//       this.mileage,
//       this.dateTime,
//       this.carMake,
//       this.carModel,
//       this.customerName,
//       this.customerContactNo,
//       this.vinNumber,
//       this.garageId,
//       this.bookingId,
//       this.createdAt,
//       this.updatedAt,
//       this.deletedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'].toString();
//     label = json['label'];
//     carImagge = json['car_imagge'];
//     carCondition = json['car_condition'];
//     workNeeded = json['work_needed'];
//     jobNumber = json['job_number'].toString();
//     jobDate = json['job_date'];
//     carRegNumber = json['car_reg_number'];
//     year = json['year'];
//     mileage = json['mileage'];
//     dateTime = json['date_time'];
//     carMake = json['car_make'];
//     carModel = json['car_model'];
//     customerName = json['customer_name'];
//     customerContactNo = json['customer_contact_no'];
//     vinNumber = json['vin_number'];
//     garageId = json['garage_id'];
//     bookingId = json['booking_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'].toString();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['label'] = this.label;
//     data['car_imagge'] = this.carImagge;
//     data['car_condition'] = this.carCondition;
//     data['work_needed'] = this.workNeeded;
//     data['job_number'] = this.jobNumber;
//     data['job_date'] = this.jobDate;
//     data['car_reg_number'] = this.carRegNumber;
//     data['year'] = this.year;
//     data['mileage'] = this.mileage;
//     data['date_time'] = this.dateTime;
//     data['car_make'] = this.carMake;
//     data['car_model'] = this.carModel;
//     data['customer_name'] = this.customerName;
//     data['customer_contact_no'] = this.customerContactNo;
//     data['vin_number'] = this.vinNumber;
//     data['garage_id'] = this.garageId;
//     data['booking_id'] = this.bookingId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     return data;
//   }
// }

class UpdateJobCardModel {
  String? code;
  String? message;

  UpdateJobCardModel({this.code, this.message});

  UpdateJobCardModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
