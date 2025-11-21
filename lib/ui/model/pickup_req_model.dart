class PickuprequestadminModel {
  String? code;
  String? message;

  PickuprequestadminModel({this.code, this.message});

  PickuprequestadminModel.fromJson(Map<String, dynamic> json) {
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
