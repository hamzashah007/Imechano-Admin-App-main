class AddServicesModel {
  String? code;
  String? message;
  Data? data;

  AddServicesModel({this.code, this.message, this.data});

  AddServicesModel.fromJson(Map<String, dynamic> json) {
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
  String? jobNumber;
  String? bookingId;
  String? serviceNumber;
  String? serviceType;
  String? serviceDesc;
  String? qty;
  String? serviceCost;
  String? total;
  String? reportType;
  String? status;
  String? updatedAt;
  String? createdAt;
  String? id;

  Data(
      {this.jobNumber,
      this.bookingId,
      this.serviceNumber,
      this.serviceType,
      this.serviceDesc,
      this.qty,
      this.serviceCost,
      this.total,
      this.reportType,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    jobNumber = json['job_number'];
    bookingId = json['booking_id'];
    serviceNumber = json['service_number'];
    serviceType = json['service_type'];
    serviceDesc = json['service_desc'];
    qty = json['qty'];
    serviceCost = json['service_cost'];
    total = json['total'];
    reportType = json['report_type'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_number'] = this.jobNumber;
    data['booking_id'] = this.bookingId;
    data['service_number'] = this.serviceNumber;
    data['service_type'] = this.serviceType;
    data['service_desc'] = this.serviceDesc;
    data['qty'] = this.qty;
    data['service_cost'] = this.serviceCost;
    data['total'] = this.total;
    data['report_type'] = this.reportType;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
