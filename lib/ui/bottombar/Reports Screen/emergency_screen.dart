import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/customer_list_bloc.dart';
import 'package:imechano_admin/ui/model/reports_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

import 'package:http/http.dart' as http;

import '../../../styling/config.dart';
import '../../../styling/global.dart';

class EmergencyScreen extends StatefulWidget {
  final String? status;
  const EmergencyScreen({Key? key, this.status}) : super(key: key);

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  int selectedindex = 1;
  List DataList = [
    ToalCustom(),
    ToalCustom1(),
    ToalCustom2(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: WidgetAppBar(
                title: 'Emergency',
                menuItem: 'assets/svg/Arrow_alt_left.svg',
                // action: 'assets/svg/add.svg',
                // action2: 'assets/svg/Alert.svg'
              ),
              body: Column(
                children: [
                  SizedBox(height: 15),
                  Expanded(
                    child: DataList[0],
                  ),
                ],
              ),
            ));
  }

  Widget card(String title, Icon icon123) {
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cardgreycolor)),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 3),
      width: 75,
      child: Row(
        children: [
          new Text(
            title,
            style: TextStyle(fontFamily: "Poppins1", fontSize: 13.sp),
          ),
          SizedBox(width: 5),
          icon123 = icon123,
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        // ignore: deprecated_member_use
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: logoBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {},
          child: Text("View Details"),
        ));
  }

  Widget cardreview(String title, bool isselected) {
    return new Container(
      decoration: BoxDecoration(
          color: isselected ? Colors.white : Color(0xff70BDF1),
          border: Border.all(color: white),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 3.1,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins1",
          color: !isselected ? Colors.white : Color(0xff70BDF1),
        ),
      ),
    );
  }
}

class ToalCustom extends StatefulWidget {
  const ToalCustom({Key? key}) : super(key: key);

  @override
  State<ToalCustom> createState() => _ToalCustomState();
}

class _ToalCustomState extends State<ToalCustom> {
  ReportsModel? reports;

  Future<ReportsModel> reportsApi() async {
    try {
      final uri = Uri.parse(Config.apiurl + "reports");
      final response =
          await http.post(uri, headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print(response.body);
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(responseJson);
        return ReportsModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return ReportsModel.fromJson(responseJson);
      } else {
        return ReportsModel.fromJson(responseJson);
      }
    } catch (exception) {
      print('exception---- $exception');
      return null!;
    }
  }

  assigningReport() async {
    reports = await reportsApi();
  }

  @override
  void initState() {
    super.initState();
    reportsApi().then((value) {
      setState(() {
        reports = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _filterwidget(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: cardgreycolor2)),
                        child: Center(
                          child: DataTable(
                            showBottomBorder: false,
                            showCheckboxColumn: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 12.w,
                            dataRowHeight: 50,
                            dividerThickness: 2,
                            horizontalMargin:
                                MediaQuery.of(context).size.width / 6.w,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: Text(
                                            'Date'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: "Poppins4"),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Booking Id'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Customer Id'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                            rows: List.generate(
                              reports?.reports?.emergency!.length ?? 0,
                              // customerListSnapshot.data!.data!.length,
                              (index) {
                                return DataRow(
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                      DataCell(Center(
                                          child: Text(
                                        formatDateString(reports?.reports
                                                ?.emergency![index].createdAt!
                                                .substring(0, 10) ??
                                            ""),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          reports?.reports?.emergency![index]
                                                  .bookingId! ??
                                              "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                          child: Text(
                                        reports?.reports?.emergency![index]
                                                .customerId! ??
                                            "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   children: [
          //     Icon(
          //       Icons.arrow_left,
          //       color: cardgreycolor,
          //     ),
          //     Center(
          //         child: Text(
          //       "Previous",
          //       style: TextStyle(fontSize: 13.sp, color: grayE6E6E5),
          //     )),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Center(
          //         child: Text("Next",
          //             style: TextStyle(fontSize: 13.sp, color: logoBlue))),
          //     Icon(Icons.arrow_right, color: logoBlue),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class ToalCustom1 extends StatefulWidget {
  const ToalCustom1({Key? key}) : super(key: key);

  @override
  State<ToalCustom1> createState() => _ToalCustom1State();
}

class _ToalCustom1State extends State<ToalCustom1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerListBloc.customerListSinck('0');
  }

  final _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _filterwidget(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: cardgreycolor2)),
                        child: Center(
                          child: DataTable(
                            showBottomBorder: false,
                            showCheckboxColumn: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 12.w,
                            dataRowHeight: 50,
                            dividerThickness: 2,
                            horizontalMargin:
                                MediaQuery.of(context).size.width / 6.w,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: Text(
                                            'Date'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: "Poppins4"),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Booking Id'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Customer Id'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                            rows: List.generate(
                              5,
                              // customerListSnapshot.data!.data!.length,
                              (index) {
                                return DataRow(
                                    // onSelectChanged: (value) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             PickCarUpPage(
                                    //                 bookingid:
                                    //                     customerListSnapshot
                                    //                         .data!
                                    //                         .data![
                                    //                             index]
                                    //                         .bookingId)),
                                    //   );
                                    // },
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        // customerListSnapshot.data!
                                        //     .data![index].plateNumber!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          // customerListSnapshot.data!
                                          //     .data![index].grageName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_left,
                color: cardgreycolor,
              ),
              Center(
                  child: Text(
                "Previous",
                style: TextStyle(fontSize: 13.sp, color: grayE6E6E5),
              )),
            ],
          ),
          Row(
            children: [
              Center(
                  child: Text("Next",
                      style: TextStyle(fontSize: 13.sp, color: logoBlue))),
              Icon(Icons.arrow_right, color: logoBlue),
            ],
          ),
        ],
      ),
    );
  }
}

class ToalCustom2 extends StatefulWidget {
  const ToalCustom2({Key? key}) : super(key: key);

  @override
  State<ToalCustom2> createState() => _ToalCustom2State();
}

class _ToalCustom2State extends State<ToalCustom2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerListBloc.customerListSinck('2');
  }

  final _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _filterwidget(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: cardgreycolor2)),
                        child: Center(
                          child: DataTable(
                            showBottomBorder: false,
                            showCheckboxColumn: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 12.w,
                            dataRowHeight: 50,
                            dividerThickness: 2,
                            horizontalMargin:
                                MediaQuery.of(context).size.width / 6.w,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: Text(
                                            'Date'.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: "Poppins4"),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Booking Id'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Customer Id'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )),
                            ],
                            rows: List.generate(
                              5,
                              // customerListSnapshot.data!.data!.length,
                              (index) {
                                return DataRow(
                                    // onSelectChanged: (value) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             PickCarUpPage(
                                    //                 bookingid:
                                    //                     customerListSnapshot
                                    //                         .data!
                                    //                         .data![
                                    //                             index]
                                    //                         .bookingId)),
                                    //   );
                                    // },
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        // customerListSnapshot.data!
                                        //     .data![index].plateNumber!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          // customerListSnapshot.data!
                                          //     .data![index].grageName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_left,
                color: cardgreycolor,
              ),
              Center(
                  child: Text(
                "Previous",
                style: TextStyle(fontSize: 13.sp, color: grayE6E6E5),
              )),
            ],
          ),
          Row(
            children: [
              Center(
                  child: Text("Next",
                      style: TextStyle(fontSize: 13.sp, color: logoBlue))),
              Icon(Icons.arrow_right, color: logoBlue),
            ],
          ),
        ],
      ),
    );
  }
}
