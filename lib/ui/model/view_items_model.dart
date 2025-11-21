class ViewItemsModel {
  int? code;
  String? message;
  List<Data>? data;
  int? request;
  Booking? booking;
  int? status;

  ViewItemsModel(
      {this.code,
      this.message,
      this.data,
      this.request,
      this.booking,
      this.status});

  ViewItemsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    request = json['request'];
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['request'] = this.request;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? id;
  String? itemId;
  String? bookingId;
  String? name;
  String? workDone;
  String? workImage;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.itemId,
      this.bookingId,
      this.name,
      this.workDone,
      this.workImage,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    itemId = json['item_id'].toString();
    bookingId = json['booking_id'].toString();
    name = json['name'];
    workDone = json['work_done'];
    workImage = json['work_image'];
    description = json['description'];
    status = json['status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['booking_id'] = this.bookingId;
    data['name'] = this.name;
    data['work_done'] = this.workDone;
    data['work_image'] = this.workImage;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Booking {
  String? id;
  String? carId;
  String? bookingId;
  String? customerId;
  String? garageId;
  String? jobNumber;
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  String? carUpload;
  String? description;
  String? timeDate;
  String? deliveryTime;
  String? address;
  String? status;
  String? pickupStatus;
  String? deliveryStatus;
  String? adminStatus;
  String? total;
  String? delieveryCharges;
  String? paymentStatus;
  String? rejectStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Booking(
      {this.id,
      this.carId,
      this.bookingId,
      this.customerId,
      this.garageId,
      this.jobNumber,
      this.categoryId,
      this.subCategoryId,
      this.itemId,
      this.carUpload,
      this.description,
      this.timeDate,
      this.deliveryTime,
      this.address,
      this.status,
      this.pickupStatus,
      this.deliveryStatus,
      this.adminStatus,
      this.total,
      this.delieveryCharges,
      this.paymentStatus,
      this.rejectStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    carId = json['car_id'].toString();
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
    garageId = json['garage_id'];
    jobNumber = json['job_number'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    itemId = json['item_id'];
    carUpload = json['car_upload'];
    description = json['description'];
    timeDate = json['time_date'];
    deliveryTime = json['delivery_time'];
    address = json['address'];
    status = json['status'];
    pickupStatus = json['pickup_status'];
    deliveryStatus = json['delivery_status'];
    adminStatus = json['admin_status'];
    total = json['total'];
    delieveryCharges = json['delievery_charges'];
    paymentStatus = json['payment_status'];
    rejectStatus = json['reject_status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['garage_id'] = this.garageId;
    data['job_number'] = this.jobNumber;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['item_id'] = this.itemId;
    data['car_upload'] = this.carUpload;
    data['description'] = this.description;
    data['time_date'] = this.timeDate;
    data['delivery_time'] = this.deliveryTime;
    data['address'] = this.address;
    data['status'] = this.status;
    data['pickup_status'] = this.pickupStatus;
    data['delivery_status'] = this.deliveryStatus;
    data['admin_status'] = this.adminStatus;
    data['total'] = this.total;
    data['delievery_charges'] = this.delieveryCharges;
    data['payment_status'] = this.paymentStatus;
    data['reject_status'] = this.rejectStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
