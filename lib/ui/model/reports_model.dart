class ReportsModel {
  int? code;
  String? message;
  Reports? reports;

  ReportsModel({this.code, this.message, this.reports});

  ReportsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    reports =
        json['reports'] != null ? new Reports.fromJson(json['reports']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.reports != null) {
      data['reports'] = this.reports!.toJson();
    }
    return data;
  }
}

class Reports {
  int? customerCount;
  String? conversions;
  int? todayCount;
  String? averageTicketSize;
  String? gvm;
  int? openOrders;
  int? atWorkShop;
  int? readyForDelivery;
  List<TotalCustomer>? totalCustomer;
  List<TotalCustomerComplete>? totalCustomerComplete;

  List<AverageTicket>? averageTicket;
  List<AverageTicketSizeComplete>? averageTicketSizeComplete;

  List<ConversionDetail>? conversionDetail;
  List<Workshop>? workshop;
  List<Workprogess>? workprogess;
  List<ReadyDeliveryPending>? readyDeliveryPending;
  List<ReadyDeliveryComplete>? readyDeliveryComplete;
  List<TodayBooking>? todayBooking;
  List<Inquiry>? inquiry;
  List<Emergency>? emergency;
  int? emergencyCount;

  Reports(
      {this.customerCount,
      this.conversions,
      this.todayCount,
      this.averageTicketSize,
      this.gvm,
      this.openOrders,
      this.atWorkShop,
      this.readyForDelivery,
      this.totalCustomer,
      this.totalCustomerComplete,
      this.averageTicket,
      this.averageTicketSizeComplete,
      this.conversionDetail,
      this.workshop,
      this.workprogess,
      this.emergency,
      this.emergencyCount,
      this.readyDeliveryPending,
      this.readyDeliveryComplete,
      this.todayBooking});

  Reports.fromJson(Map<String, dynamic> json) {
    customerCount = json['customer_count'];
    conversions = json['conversions'];
    todayCount = json['todayCount'];
    averageTicketSize = json['averageTicketSize'];
    gvm = json['gvm'];
    openOrders = json['open_orders'];
    atWorkShop = json['atWorkShop'];
    readyForDelivery = json['readyForDelivery'];
    if (json['total_customer'] != null) {
      totalCustomer = <TotalCustomer>[];
      json['total_customer'].forEach((v) {
        totalCustomer!.add(new TotalCustomer.fromJson(v));
      });
    }

    if (json['averageTicketSizeComplete'] != null) {
      averageTicketSizeComplete = <AverageTicketSizeComplete>[];
      json['averageTicketSizeComplete'].forEach((v) {
        averageTicketSizeComplete!
            .add(new AverageTicketSizeComplete.fromJson(v));
      });
    }

    if (json['total_customer_complete'] != null) {
      totalCustomerComplete = <TotalCustomerComplete>[];
      json['total_customer_complete'].forEach((v) {
        totalCustomerComplete!.add(new TotalCustomerComplete.fromJson(v));
      });
    }

    if (json['average_ticket'] != null) {
      averageTicket = <AverageTicket>[];
      json['average_ticket'].forEach((v) {
        averageTicket!.add(new AverageTicket.fromJson(v));
      });
    }
    if (json['conversion_detail'] != null) {
      conversionDetail = <ConversionDetail>[];
      json['conversion_detail'].forEach((v) {
        conversionDetail!.add(new ConversionDetail.fromJson(v));
      });
    }

    if (json['workshop'] != null) {
      workshop = <Workshop>[];
      json['workshop'].forEach((v) {
        workshop!.add(new Workshop.fromJson(v));
      });
    }
    if (json['workprogess'] != null) {
      workprogess = <Workprogess>[];
      json['workprogess'].forEach((v) {
        workprogess!.add(new Workprogess.fromJson(v));
      });
    }

    if (json['emergency'] != null) {
      emergency = <Emergency>[];
      json['emergency'].forEach((v) {
        emergency!.add(new Emergency.fromJson(v));
      });
    }
    emergencyCount = json['emergency_count'];

    if (json['ready_delivery_pending'] != null) {
      readyDeliveryPending = <ReadyDeliveryPending>[];
      json['ready_delivery_pending'].forEach((v) {
        readyDeliveryPending!.add(new ReadyDeliveryPending.fromJson(v));
      });
    }

    if (json['ready_delivery_complete'] != null) {
      readyDeliveryComplete = <ReadyDeliveryComplete>[];
      json['ready_delivery_complete'].forEach((v) {
        readyDeliveryComplete!.add(new ReadyDeliveryComplete.fromJson(v));
      });
    }

    if (json['today_booking'] != null) {
      todayBooking = <TodayBooking>[];
      json['today_booking'].forEach((v) {
        todayBooking!.add(new TodayBooking.fromJson(v));
      });
    }
    if (json['inquiry'] != null) {
      inquiry = <Inquiry>[];
      json['inquiry'].forEach((v) {
        inquiry!.add(new Inquiry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_count'] = this.customerCount;
    data['conversions'] = this.conversions;
    data['todayCount'] = this.todayCount;
    data['averageTicketSize'] = this.averageTicketSize;
    data['gvm'] = this.gvm;
    data['open_orders'] = this.openOrders;
    data['atWorkShop'] = this.atWorkShop;
    data['readyForDelivery'] = this.readyForDelivery;
    if (this.totalCustomer != null) {
      data['total_customer'] =
          this.totalCustomer!.map((v) => v.toJson()).toList();
    }
    if (this.totalCustomerComplete != null) {
      data['total_customer_complete'] =
          this.totalCustomerComplete!.map((v) => v.toJson()).toList();
    }
    if (this.averageTicket != null) {
      data['average_ticket'] =
          this.averageTicket!.map((v) => v.toJson()).toList();
    }
    if (this.averageTicketSizeComplete != null) {
      data['averageTicketSizeComplete'] =
          this.averageTicketSizeComplete!.map((v) => v.toJson()).toList();
    }
    if (this.conversionDetail != null) {
      data['conversion_detail'] =
          this.conversionDetail!.map((v) => v.toJson()).toList();
    }
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.map((v) => v.toJson()).toList();
    }
    if (this.workprogess != null) {
      data['workprogess'] = this.workprogess!.map((v) => v.toJson()).toList();
    }
    if (this.readyDeliveryPending != null) {
      data['ready_delivery_pending'] =
          this.readyDeliveryPending!.map((v) => v.toJson()).toList();
    }
    if (this.readyDeliveryComplete != null) {
      data['ready_delivery_complete'] =
          this.readyDeliveryComplete!.map((v) => v.toJson()).toList();
    }

    if (this.todayBooking != null) {
      data['today_booking'] =
          this.todayBooking!.map((v) => v.toJson()).toList();
    }
    if (this.inquiry != null) {
      data['inquiry'] = this.inquiry!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emergency {
  String? createdAt;
  String? bookingId;
  String? customerId;

  Emergency({this.createdAt, this.bookingId, this.customerId});

  Emergency.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class AverageTicketSizeComplete {
  String? createdAt;
  String? bookingId;
  String? garageName;
  String? customerId;

  AverageTicketSizeComplete(
      {this.createdAt, this.bookingId, this.garageName, this.customerId});

  AverageTicketSizeComplete.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'].toString();
    garageName = json['garage_name'];
    customerId = json['customer_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['garage_name'] = this.garageName;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class Inquiry {
  String? createdAt;
  String? bookingId;
  String? customerId;

  Inquiry({this.createdAt, this.bookingId, this.customerId});

  Inquiry.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class ReadyDeliveryComplete {
  String? createdAt;
  String? bookingId;
  String? garageName;
  String? customerName;
  String? carRegNumber;

  ReadyDeliveryComplete(
      {this.createdAt,
      this.bookingId,
      this.garageName,
      this.customerName,
      this.carRegNumber});

  ReadyDeliveryComplete.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'];
    garageName = json['garage_name'];
    customerName = json['customer_name'];
    carRegNumber = json['car_reg_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['garage_name'] = this.garageName;
    data['customer_name'] = this.customerName;
    data['car_reg_number'] = this.carRegNumber;
    return data;
  }
}

class TotalCustomerComplete {
  String? plateNumber;
  String? customerId;
  String? garageName;
  String? model;
  String? name;
  String? brand;

  TotalCustomerComplete(
      {this.plateNumber,
      this.customerId,
      this.garageName,
      this.model,
      this.name,
      this.brand});

  TotalCustomerComplete.fromJson(Map<String, dynamic> json) {
    plateNumber = json['plate_number'];
    customerId = json['customer_id'].toString();
    garageName = json['garage_name'];
    model = json['model'];
    name = json['name'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plate_number'] = this.plateNumber;
    data['customer_id'] = this.customerId;
    data['garage_name'] = this.garageName;
    data['model'] = this.model;
    data['name'] = this.name;
    data['brand'] = this.brand;
    return data;
  }
}

class Workshop {
  String? createdAt;
  String? customerId;
  String? garageName;
  String? bookingId;

  Workshop({this.createdAt, this.customerId, this.garageName, this.bookingId});

  Workshop.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    customerId = json['customer_id'].toString();
    garageName = json['garage_name'];
    bookingId = json['booking_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['customer_id'] = this.customerId;
    data['garage_name'] = this.garageName;
    data['booking_id'] = this.bookingId;
    return data;
  }
}

class Workprogess {
  String? id;
  String? createdAt;
  String? bookingId;
  String? garageName;
  String? customerName;
  String? carRegNumber;

  Workprogess(
      {this.id,
      this.createdAt,
      this.bookingId,
      this.garageName,
      this.customerName,
      this.carRegNumber});

  Workprogess.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    createdAt = json['created_at'];
    bookingId = json['booking_id'];
    garageName = json['garage_name'];
    customerName = json['customer_name'];
    carRegNumber = json['car_reg_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['garage_name'] = this.garageName;
    data['customer_name'] = this.customerName;
    data['car_reg_number'] = this.carRegNumber;
    return data;
  }
}

class ReadyDeliveryPending {
  String? createdAt;
  String? bookingId;
  String? garageName;
  String? customerName;
  String? carRegNumber;

  ReadyDeliveryPending(
      {this.createdAt,
      this.bookingId,
      this.garageName,
      this.customerName,
      this.carRegNumber});

  ReadyDeliveryPending.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'];
    garageName = json['garage_name'];
    customerName = json['customer_name'];
    carRegNumber = json['car_reg_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['garage_name'] = this.garageName;
    data['customer_name'] = this.customerName;
    data['car_reg_number'] = this.carRegNumber;
    return data;
  }
}

class TodayBooking {
  String? createdAt;
  String? bookingId;
  String? customerId;

  TodayBooking({this.createdAt, this.bookingId, this.customerId});

  TodayBooking.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class TotalCustomer {
  String? plateNumber;
  String? customerId;
  String? garageName;
  String? model;
  String? name;
  String? brand;

  TotalCustomer(
      {this.plateNumber,
      this.customerId,
      this.garageName,
      this.model,
      this.name,
      this.brand});

  TotalCustomer.fromJson(Map<String, dynamic> json) {
    plateNumber = json['plate_number'];
    customerId = json['customer_id'].toString();
    garageName = json['garage_name'];
    model = json['model'];
    name = json['name'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plate_number'] = this.plateNumber;
    data['customer_id'] = this.customerId;
    data['garage_name'] = this.garageName;
    data['model'] = this.model;
    data['name'] = this.name;
    data['brand'] = this.brand;
    return data;
  }
}

class AverageTicket {
  String? createdAt;
  String? bookingId;
  String? garageName;
  String? customerId;

  AverageTicket(
      {this.createdAt, this.bookingId, this.garageName, this.customerId});

  AverageTicket.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'].toString();
    garageName = json['garage_name'];
    customerId = json['customer_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['garage_name'] = this.garageName;
    data['customer_id'] = this.customerId;
    return data;
  }
}

class ConversionDetail {
  String? createdAt;
  String? bookingId;
  String? garageName;
  String? customerName;
  String? carRegNumber;

  ConversionDetail(
      {this.createdAt,
      this.bookingId,
      this.garageName,
      this.customerName,
      this.carRegNumber});

  ConversionDetail.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    bookingId = json['booking_id'];
    garageName = json['garage_name'];
    customerName = json['customer_name'];
    carRegNumber = json['car_reg_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['booking_id'] = this.bookingId;
    data['garage_name'] = this.garageName;
    data['customer_name'] = this.customerName;
    data['car_reg_number'] = this.carRegNumber;
    return data;
  }
}
