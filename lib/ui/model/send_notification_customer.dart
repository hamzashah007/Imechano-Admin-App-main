class SendNotificationCustomerModel {
  String? code;
  String? message;

  SendNotificationCustomerModel({this.code, this.message});

  SendNotificationCustomerModel.fromJson(Map<String, dynamic> json) {
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
