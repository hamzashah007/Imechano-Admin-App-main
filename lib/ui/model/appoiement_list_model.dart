
class AppoiementListModel {
  String? code;
  String? message;
  List<Data>? data;

  AppoiementListModel({this.code, this.message, this.data});

  AppoiementListModel.fromJson(Map<String, dynamic> json) {
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
  String? jobNumber;
  String? jobDate;
  String? carId;
  String? customerId;
  String? appointmentTime;
  String? deliveryScheduled;
  String? garageId;
  String? pickupStatus;
  String? deliveryStatus;
  String? paymentStatus;
  String? carImage;
  String? customerName;
  String? garageProfile;
  String? garageName;
  String? jobCardStatus;
  String? paymentMethod;

  Data(
      {this.id,
      this.bookingId,
      this.jobNumber,
      this.jobDate,
      this.carId,
      this.customerId,
      this.appointmentTime,
      this.deliveryScheduled,
      this.garageId,
      this.pickupStatus,
      this.deliveryStatus,
      this.paymentStatus,
      this.jobCardStatus,
      this.carImage,
      this.customerName,
      this.garageProfile,
      this.paymentMethod,
      this.garageName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    bookingId = json['booking_id'].toString();
    jobNumber = json['job_number'] ?? '';
    jobDate = json['job_date'] ?? "";
    carId = json['car_id'].toString();
    customerId = json['customer_id'].toString();
    appointmentTime = json['time_date'] ?? '';
    deliveryScheduled = json['delivery_time'];
    garageId = json['garage_id'] ?? '';
    pickupStatus = json['pickup_status'] ?? '';
    deliveryStatus = json['delivery_status'] ?? '';
    paymentStatus = json['payment_status'] ?? '';
    jobCardStatus = json['jobcard_status'].toString();
    carImage = json['car_image'] ?? '';
    customerName = json['customer_name'] ?? '';
    garageProfile = json['garage_profile'] ?? '';
    garageName = json['garage_name'] ?? '';
    switch (json['payment_method']) {
      case null:
        paymentMethod = 'Pending';
        break;
      case 0:
        paymentMethod = 'Pending';
        break;
      case 1:
        paymentMethod = 'Cash';
        break;
      case 2:
        paymentMethod = 'POS';
        break;
      case 3:
        paymentMethod = 'Online Payment';
        break;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['job_number'] = this.jobNumber;
    data['job_date'] = this.jobDate;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['time_date'] = this.appointmentTime;
    data['delivery_time'] = this.deliveryScheduled;
    data['garage_id'] = this.garageId;
    data['pickup_status'] = this.pickupStatus;
    data['delivery_status'] = this.deliveryStatus;
    data['payment_status'] = this.paymentStatus;
    data['car_image'] = this.carImage;
    data['customer_name'] = this.customerName;
    data['garage_profile'] = this.garageProfile;
    return data;
  }
}
