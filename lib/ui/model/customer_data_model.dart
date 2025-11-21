class CustomerDataModel {
  String? code;
  String? message;
  List<CustomerData>? data;

  CustomerDataModel({this.code, this.message, this.data});

  CustomerDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <CustomerData>[];
      json['data'].forEach((v) {
        data!.add(CustomerData.fromJson(v));
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
  String? currentPage;
  List<CustomerData>? data;
  String? firstPageUrl;
  String? from;
  String? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  String? to;
  String? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'].toString();
    if (json['data'] != null) {
      data = <CustomerData>[];
      json['data'].forEach((v) {
        data!.add(new CustomerData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'].toString();
    lastPage = json['last_page'].toString();
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'].toString();
    prevPageUrl = json['prev_page_url'].toString();
    to = json['to'].toString();
    total = json['total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class CustomerData {
  String? id;
  String? bookingId;
  String? customerId;
  String? garageId;
  String? customerName;
  String? mobileNumber;
  String? garageProfile;

  CustomerData(
      {this.id,
      this.bookingId,
      this.customerId,
      this.garageId,
      this.customerName,
      this.mobileNumber,
      this.garageProfile});

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
    garageId = json['garage_id'].toString();
    customerName = json['customer_name'];
    mobileNumber = json['mobile_number'];
    garageProfile = json['garage_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['garage_id'] = this.garageId;
    data['customer_name'] = this.customerName;
    data['mobile_number'] = this.mobileNumber;
    data['garage_profile'] = this.garageProfile;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}



// class CustomerDataModel {
//   String? code;
//   String? message;
//   List<Data>? data;

//   CustomerDataModel({this.code, this.message, this.data});

//   CustomerDataModel.fromJson(Map<String, dynamic> json) {
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

// class Data {
//   String? id;
//   String? bookingId;
//   String? customerId;
//   String? garageId;
//   String? customerName;
//   String? mobileNumber;
//   String? garageProfile;

//   Data(
//       {this.id,
//       this.bookingId,
//       this.customerId,
//       this.garageId,
//       this.customerName,
//       this.mobileNumber,
//       this.garageProfile});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'].toString();
//     bookingId = json['booking_id'];
//     customerId = json['customer_id'];
//     garageId = json['garage_id'];
//     customerName = json['customer_name'];
//     mobileNumber = json['mobile_number'];
//     garageProfile = json['garage_profile'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['booking_id'] = this.bookingId;
//     data['customer_id'] = this.customerId;
//     data['garage_id'] = this.garageId;
//     data['customer_name'] = this.customerName;
//     data['mobile_number'] = this.mobileNumber;
//     data['garage_profile'] = this.garageProfile;
//     return data;
//   }
// }
