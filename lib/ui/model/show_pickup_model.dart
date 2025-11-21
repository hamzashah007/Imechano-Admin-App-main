// import 'package:imechano_admin/ui/model/view_service_model.dart';

// class ShowpickuppartsModel {
//   String? code;
//   String? message;
//   List<Data>? data;

//   ShowpickuppartsModel({this.code, this.message, this.data});

//   ShowpickuppartsModel.fromJson(Map<String, dynamic> json) {
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
