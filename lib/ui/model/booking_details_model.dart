class BookingDetailsModel {
  int? id;
  String? carId;
  String? bookingId;
  String? customerId;
  String? garageId;
  String? jobNumber;
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  String? carUpload;
  String? carImage;
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
  String? subcategoryName;
  List<Items>? items;
  Customer? customer;
  String? carBrand;
  String? carModel;
  String? carYear;
  String? carChasis;
  String? carName;
  String? carMileage;
  String? carCylinders;

  BookingDetailsModel(
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
      this.deletedAt,
      this.subcategoryName,
      this.items,
      this.customer,
      this.carBrand,
      this.carModel,
      this.carYear,
      this.carChasis,
      this.carName,
      this.carMileage,
      this.carCylinders});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['car_id'].toString();
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
    garageId = json['garage_id'] ?? " ";
    jobNumber = json['job_number'] ?? " ";
    categoryId = json['category_id'] ?? " ";
    subCategoryId = json['sub_category_id'] ?? " ";
    itemId = json['item_id'];
    carUpload = json['car_upload'];
    carImage = json['car_image'];
    description = json['description'];
    timeDate = json['time_date'];
    deliveryTime = json['delivery_time'] ?? " ";
    address = json['address'] ?? '';
    status = json['status'];
    pickupStatus = json['pickup_status'];
    deliveryStatus = json['delivery_status'];
    adminStatus = json['admin_status'];
    total = json['total'] ?? " ";
    delieveryCharges = json['delievery_charges'] ?? "";
    paymentStatus = json['payment_status'] ?? "";
    rejectStatus = json['reject_status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? "";
    subcategoryName = json['subcategory_name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    customer = new Customer.fromJson(json['customer']);
    carBrand = json['car_brand'];
    carModel = json['car_model'];
    carYear = json['car_year'];
    carChasis = json['car_chasis'] ?? " ";
    carName = json['car_name'];
    carMileage = json['car_mileage'] ?? '';
    carCylinders = json['car_cylinder'] ?? '';
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
    data['subcategory_name'] = this.subcategoryName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['car_brand'] = this.carBrand;
    data['car_model'] = this.carModel;
    data['car_year'] = this.carYear;
    data['car_chasis'] = this.carChasis;
    data['car_name'] = this.carName;
    data['car_mileage'] = this.carMileage;
    data['car_cylinder'] = this.carCylinders;
    return data;
  }
}

class Items {
  int? id;
  String? subCategoryId;
  String? item;
  String? price;
  String? description;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  Items(
      {this.id,
      this.subCategoryId,
      this.item,
      this.price,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['sub_category_id'].toString();
    item = json['item'];
    price = json['price'] ?? "";
    description = json['description'] ?? " ";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['item'] = this.item;
    data['price'] = this.price;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Customer {
  String? name;
  String? mobileNumber;
  String? longitude;
  String? latitude;

  Customer({this.name, this.mobileNumber, this.longitude, this.latitude});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    longitude = json['longitude'] ?? '';
    latitude = json['latitude'] ?? '';
    mobileNumber = json['mobile_number'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
