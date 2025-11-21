class GarageInvoiceModel {
  int? code;
  String? message;
  List<Data>? data;

  GarageInvoiceModel({this.code, this.message, this.data});

  GarageInvoiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
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
  String? bookingId;
  String? customerId;
  String? carPlateNo;
  String? garageName;
  String? garageInvoice;

  Data(
      {this.bookingId,
      this.customerId,
      this.carPlateNo,
      this.garageName,
      this.garageInvoice});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'] ?? "";
    customerId = json['customer_id'] ?? "";
    carPlateNo = json['car_plate_no'] ?? "";
    garageName = json['garage_name'] ?? "";
    garageInvoice = json['garage_invoice'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['car_plate_no'] = this.carPlateNo;
    data['garage_name'] = this.garageName;
    data['garage_invoice'] = this.garageInvoice;
    return data;
  }
}
