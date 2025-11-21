import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/bloc/customer_list_bloc.dart';
import 'package:imechano_admin/ui/bottombar/pickup_and%20_fix_page.dart';
import 'package:imechano_admin/ui/model/customer_list_model.dart';
import 'package:imechano_admin/ui/model/reports_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:http/http.dart' as http;

import '../../../styling/global.dart';
import '../../screens/drawer/my_job.dart';

class Workprogress extends StatefulWidget {
  final String? status;
  const Workprogress({Key? key, this.status}) : super(key: key);

  @override
  _WorkprogressState createState() => _WorkprogressState();
}

class _WorkprogressState extends State<Workprogress> {
  int selectedindex = 1;
  List DataList = [
    ToalCustom(),
    ToalCustom1(),
    // ToalCustom2(),
  ];

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
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              appBar: WidgetAppBar(
                title: 'Cars in progress',
                menuItem: 'assets/svg/Arrow_alt_left.svg',
              ),
              body: Column(
                children: [
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
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
                                    side: BorderSide(
                                        width: 2, color: cardgreycolor2)),
                                child: Center(
                                  child: DataTable(
                                    showBottomBorder: false,
                                    showCheckboxColumn: false,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => white),
                                    columnSpacing: 9.w,
                                    dataRowHeight: 50,
                                    dividerThickness: 2,
                                    horizontalMargin:
                                        MediaQuery.of(context).size.width /
                                            13.w,
                                    columns: [
                                      DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Date'.toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins4"),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          numeric: false),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Job nUmber'.toUpperCase(),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Customer Name'.toUpperCase(),
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
                                        child: Text(
                                          'Garage Assigned'.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins4"),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Expanded(
                                        child: Text(
                                          'View Details'.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins4"),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                    ],
                                    rows: List.generate(
                                      reports?.reports?.workprogess!.length ??
                                          0,
                                      (index) {
                                        return DataRow(
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) {
                                              return index % 2 == 0
                                                  ? Color(0xFFF5FAFF)
                                                  : white; //make tha magic!
                                            }),
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(
                                                formatDateString(reports
                                                        ?.reports
                                                        ?.workprogess![index]
                                                        .createdAt!
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
                                                  reports
                                                          ?.reports
                                                          ?.workprogess![index]
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
                                                reports
                                                        ?.reports
                                                        ?.workprogess![index]
                                                        .id! ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins3"),
                                              ))),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                  child: Text(
                                                reports
                                                        ?.reports
                                                        ?.workprogess![index]
                                                        .customerName! ??
                                                    "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins3"),
                                              ))),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                child: Text(
                                                  reports
                                                          ?.reports
                                                          ?.workprogess![index]
                                                          .garageName! ??
                                                      "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ),
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyJobCard(
                                                            job_number: reports
                                                                    ?.reports
                                                                    ?.workprogess![
                                                                        index]
                                                                    .id! ??
                                                                "",
                                                          ),
                                                        ));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                      color: logoBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                    child: Text(
                                                      "View Details "
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )),
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
            ));
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
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
      width: 150.w,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerListBloc.customerListSinck('1');
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
                child: StreamBuilder<CustomerListModel>(
                    stream: customerListBloc.CustomerListStream,
                    builder: (context,
                        AsyncSnapshot<CustomerListModel> customerListSnapshot) {
                      if (!customerListSnapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return customerListSnapshot.data!.data!.length == 0
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: Text(
                                  'No Data Found',
                                  style: TextStyle(
                                      fontFamily: 'Poppins1', fontSize: 18.sp),
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: cardgreycolor2)),
                                  child: Center(
                                    child: DataTable(
                                      showBottomBorder: false,
                                      showCheckboxColumn: false,
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => white),
                                      columnSpacing: 20.w,
                                      dataRowHeight: 50,
                                      dividerThickness: 2,
                                      horizontalMargin: 15.w,
                                      columns: [
                                        DataColumn(
                                            label: Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'PLATE',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily: "Poppins4"),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    'NUMBER',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily: "Poppins4"),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            numeric: false),
                                        DataColumn(label: _verticalDivider),
                                        DataColumn(
                                            label: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'GARAGE',
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins4"),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'ASSIGNED',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'CARS UNDER',
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins4"),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'THAT CUSTOMER',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'CUSTOMER',
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins4"),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'NAME',
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
                                        customerListSnapshot.data!.data!.length,
                                        (index) {
                                          return DataRow(
                                              onSelectChanged: (value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PickCarUpPage(
                                                              bookingid:
                                                                  customerListSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .bookingId)),
                                                );
                                              },
                                              color: MaterialStateColor
                                                  .resolveWith((states) {
                                                return index % 2 == 0
                                                    ? Color(0xFFF5FAFF)
                                                    : white; //make tha magic!
                                              }),
                                              cells: [
                                                DataCell(Center(
                                                    child: Text(
                                                  customerListSnapshot
                                                      .data!
                                                      .data![index]
                                                      .plateNumber!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ))),
                                                DataCell(_verticalDivider),
                                                DataCell(Center(
                                                  child: Text(
                                                    customerListSnapshot
                                                        .data!
                                                        .data![index]
                                                        .grageName!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily: "Poppins3"),
                                                  ),
                                                )),
                                                DataCell(_verticalDivider),
                                                DataCell(Center(
                                                    child: Text(
                                                  customerListSnapshot
                                                      .data!
                                                      .data![index]
                                                      .carsUnderCustomer!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ))),
                                                DataCell(_verticalDivider),
                                                DataCell(Center(
                                                  child: Text(
                                                    customerListSnapshot
                                                        .data!
                                                        .data![index]
                                                        .customerName!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily: "Poppins3"),
                                                  ),
                                                )),
                                              ]);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    }),
              ),
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
                child: StreamBuilder<CustomerListModel>(
                    stream: customerListBloc.CustomerListStream,
                    builder: (context,
                        AsyncSnapshot<CustomerListModel> customerListSnapshot) {
                      if (!customerListSnapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return customerListSnapshot.data!.data!.length == 0
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: Text(
                                  'No Data Found',
                                  style: TextStyle(
                                      fontFamily: 'Poppins1', fontSize: 18.sp),
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: cardgreycolor2)),
                                child: Center(
                                  child: DataTable(
                                    showBottomBorder: false,
                                    showCheckboxColumn: false,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => white),
                                    columnSpacing: 10.w,
                                    dataRowHeight: 50,
                                    dividerThickness: 2,
                                    horizontalMargin: 15.w,
                                    columns: [
                                      DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'PLATE',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins4"),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  'NUMBER',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins4"),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          numeric: false),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'GARAGE',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Poppins4"),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'ASSIGNED',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'CARS UNDER',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Poppins4"),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'THAT CUSTOMER',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'CUSTOMER',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Poppins4"),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'NAME',
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
                                      customerListSnapshot.data!.data!.length,
                                      (index) {
                                        return DataRow(
                                            onSelectChanged: (value) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PickCarUpPage(
                                                            bookingid:
                                                                customerListSnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .bookingId)),
                                              );
                                            },
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) {
                                              return index % 2 == 0
                                                  ? Color(0xFFF5FAFF)
                                                  : white; //make tha magic!
                                            }),
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(
                                                customerListSnapshot.data!
                                                    .data![index].plateNumber!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins3"),
                                              ))),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                child: Text(
                                                  customerListSnapshot.data!
                                                      .data![index].grageName!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ),
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                  child: Text(
                                                customerListSnapshot
                                                    .data!
                                                    .data![index]
                                                    .carsUnderCustomer!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins3"),
                                              ))),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                child: Text(
                                                  customerListSnapshot
                                                      .data!
                                                      .data![index]
                                                      .customerName!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ),
                                              )),
                                            ]);
                                      },
                                    ),
                                  ),
                                ),
                              ));
                    }),
              ),
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
                child: StreamBuilder<CustomerListModel>(
                    stream: customerListBloc.CustomerListStream,
                    builder: (context,
                        AsyncSnapshot<CustomerListModel> customerListSnapshot) {
                      if (!customerListSnapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return customerListSnapshot.data!.data!.length == 0
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: Text(
                                  'No Data Found',
                                  style: TextStyle(
                                      fontFamily: 'Poppins1', fontSize: 18.sp),
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: cardgreycolor2)),
                                child: Center(
                                  child: DataTable(
                                    showBottomBorder: false,
                                    showCheckboxColumn: false,
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => white),
                                    columnSpacing: 15.w,
                                    dataRowHeight: 50,
                                    dividerThickness: 2,
                                    horizontalMargin: 15.w,
                                    columns: [
                                      DataColumn(
                                          label: Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'PLATE',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins4"),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  'NUMBER',
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins4"),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          numeric: false),
                                      DataColumn(label: _verticalDivider),
                                      DataColumn(
                                          label: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'GARAGE',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Poppins4"),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'ASSIGNED',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'CARS UNDER',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Poppins4"),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'THAT CUSTOMER',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'CUSTOMER',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontFamily: "Poppins4"),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              'NAME',
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
                                      customerListSnapshot.data!.data!.length,
                                      (index) {
                                        return DataRow(
                                            onSelectChanged: (value) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PickCarUpPage(
                                                            bookingid:
                                                                customerListSnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .bookingId)),
                                              );
                                            },
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) {
                                              return index % 2 == 0
                                                  ? Color(0xFFF5FAFF)
                                                  : white; //make tha magic!
                                            }),
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(
                                                customerListSnapshot.data!
                                                    .data![index].plateNumber!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins3"),
                                              ))),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                child: Text(
                                                  customerListSnapshot.data!
                                                      .data![index].grageName!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ),
                                              )),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                  child: Text(
                                                customerListSnapshot
                                                    .data!
                                                    .data![index]
                                                    .carsUnderCustomer!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: "Poppins3"),
                                              ))),
                                              DataCell(_verticalDivider),
                                              DataCell(Center(
                                                child: Text(
                                                  customerListSnapshot
                                                      .data!
                                                      .data![index]
                                                      .customerName!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontFamily: "Poppins3"),
                                                ),
                                              )),
                                            ]);
                                      },
                                    ),
                                  ),
                                ),
                              ));
                    }),
              ),
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
