class AddPartesModel {
  String? code;
  String? message;
  Data? data;

  AddPartesModel({this.code, this.message, this.data});

  AddPartesModel.fromJson(Map<String, dynamic> json) {
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
  String? partNumber;
  String? partType;
  String? partDesc;
  String? qty;
  String? estCost;
  String? total;
  String? reportType;
  String? status;
  String? updatedAt;
  String? createdAt;
  String? id;

  Data(
      {this.jobNumber,
      this.bookingId,
      this.partNumber,
      this.partType,
      this.partDesc,
      this.qty,
      this.estCost,
      this.total,
      this.reportType,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    jobNumber = json['job_number'];
    bookingId = json['booking_id'];
    partNumber = json['part_number'];
    partType = json['part_type'];
    partDesc = json['part_desc'];
    qty = json['qty'];
    estCost = json['est_cost'];
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
    data['part_number'] = this.partNumber;
    data['part_type'] = this.partType;
    data['part_desc'] = this.partDesc;
    data['qty'] = this.qty;
    data['est_cost'] = this.estCost;
    data['total'] = this.total;
    data['report_type'] = this.reportType;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
