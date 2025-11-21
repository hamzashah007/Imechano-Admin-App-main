class ViewServiceModel {
  String? code;
  String? message;
  List<Data>? data;
  String? mainTotal;

  ViewServiceModel({this.code, this.message, this.data, this.mainTotal});

  ViewServiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    mainTotal = json['main_total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['main_total'] = this.mainTotal;
    return data;
  }
}

class Data {
  String? id;
  String? jobNumber;
  String? bookingId;
  String? status;

  String? serviceNumber;
  String? serviceType;
  String? serviceDesc;
  String? serviceName;
  String? qty;
  String? serviceCost;
  String? total;
  String? reportType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.jobNumber,
      this.bookingId,
      this.status,
      this.serviceName,
      this.serviceNumber,
      this.serviceType,
      this.serviceDesc,
      this.qty,
      this.serviceCost,
      this.total,
      this.reportType,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    jobNumber = json['job_number'].toString();
    bookingId = json['booking_id'].toString();
    status = json['status'].toString();
    serviceName = json['service_name'] ?? '';
    serviceNumber = json['service_number'].toString();
    serviceType = json['service_type'].toString();
    serviceDesc = json['service_desc'].toString();
    qty = json['qty'].toString();
    serviceCost = json['service_cost'].toString();
    total = json['total'].toString();
    reportType = json['report_type'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_number'] = this.jobNumber;
    data['booking_id'] = this.bookingId;
    data['status'] = this.status;
    data['service_number'] = this.serviceNumber;
    data['service_type'] = this.serviceType;
    data['service_desc'] = this.serviceDesc;
    data['qty'] = this.qty;
    data['service_cost'] = this.serviceCost;
    data['total'] = this.total;
    data['report_type'] = this.reportType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
