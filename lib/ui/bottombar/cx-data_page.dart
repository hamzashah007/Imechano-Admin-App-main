// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/customer_data_bloc.dart';
import 'package:imechano_admin/ui/bottombar/cx_data.dart';
import 'package:imechano_admin/ui/model/customer_data_model.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:intl/intl.dart';

class CxDataPage extends StatefulWidget {
  const CxDataPage({Key? key, this.customer_id}) : super(key: key);
  final String? customer_id;

  @override
  _CxDataPageState createState() => _CxDataPageState();
}

class _CxDataPageState extends State<CxDataPage> {
  int page = 0;
  List<Data> data = [];
  bool isFinish = false;

  @override
  void initState() {
    customerdataaPIbloc.oncustomerdatablocSink('1');
    super.initState();
  }

  String search = "";
  bool showFilter = false;

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 20);

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;
      await customerdataaPIbloc.oncustomerdatablocSink('1');
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;
      await customerdataaPIbloc.oncustomerdatablocSink('1');
      setState(() {});
    }
    return _date;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: WidgetAppBar(
                title: 'Cx Data',
                menuItem: 'assets/svg/Arrow_alt_left.svg',
                // action: 'assets/svg/add.svg',
                // action2: 'assets/svg/Alert.svg'
              ),
              body: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      // _filterwidget(),
                      // _searchfilterwidget(),
                      SizedBox(height: size.height * 0.01),
                      _searchfilterwidget(),
                      if (showFilter) ...[
                        // These children are only visible if condition is true
                        SizedBox(height: size.height * 0.01),
                        _filterwidget(),
                      ],
                      SizedBox(height: size.height * 0.01),
                      Expanded(
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: SingleChildScrollView(
                            child: Center(child: table())),
                      )),
                    ],
                  )),
            ));
  }

  Widget _searchfilterwidget() {
    return Container(
      height: 40.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              height: 60,
              margin: EdgeInsets.only(left: 17.w, right: 5.w),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.search_outlined)),
                  hintText: "Search",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      fontFamily: "Poppins3",
                      color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.only(bottom: 2),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // _showBottomSheet(context);
              setState(() {
                showFilter = !showFilter;
              });
            },
            child: card(
                "Filter",
                Icon(
                  Icons.filter_list_alt,
                  size: 17,
                  color: logoBlue,
                )),
          ),
        ],
      ),
    );
  }

  Widget _filterwidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              fromDate = await selectDate(context, fromDate, 'toDate');
            },
            child: Column(
              children: [
                Text(
                  "Start Date",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 96.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: black12color),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${formatter.format(fromDate)}",
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: 'Poppins3'),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              log('Before to date');
              toDate = await selectToDate(context, toDate, 'fromDate');
              log('After to date');
            },
            child: Column(
              children: [
                Text(
                  "End Date",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 96.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: black12color),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${formatter.format(toDate)}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: 'Poppins3',
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print("I m pressed");
              selectFirstDate();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
              child: Container(
                width: 80.w,
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: black12color),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: 'Poppins3',
                      ),
                    ),
                    Icon(
                      Icons.filter_list_alt,
                      size: 16.h,
                      color: logoBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    formatter.format(DateTime(DateTime.now().year, 12, DateTime.now().day));
  }
  // Widget _filterwidget() {
  //   return Container(
  //     height: 30.h,
  //     margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             page = page - 1;
  //             customerdataaPIbloc.oncustomerdatablocSink(page.toString());

  //             setState(() {});
  //           },
  //           child: Container(
  //             child: Row(
  //               children: [
  //                 Icon(
  //                   Icons.arrow_left,
  //                   color: logoBlue,
  //                 ),
  //                 Text(
  //                   "Previous",
  //                   style: TextStyle(fontSize: 13.sp, color: logoBlue),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 3.h),
  //         VerticalDivider(),
  //         SizedBox(width: 3.h),
  //         card(
  //             "Filter",
  //             Icon(
  //               Icons.filter_list_alt,
  //               size: 17,
  //               color: logoBlue,
  //             )),
  //         SizedBox(width: 3.h),
  //         VerticalDivider(),
  //         SizedBox(width: 3.h),
  //         card("Sort", Icon(Icons.filter_list, size: 17, color: logoBlue)),
  //         SizedBox(width: 3.h),
  //         VerticalDivider(),
  //         SizedBox(width: 3.h),
  //         GestureDetector(
  //           onTap: () {
  //             page = page + 1;
  //             customerdataaPIbloc.oncustomerdatablocSink(page.toString());

  //             setState(() {});
  //           },
  //           child: Container(
  //             child: Row(
  //               children: [
  //                 Text("Next",
  //                     style: TextStyle(fontSize: 13.sp, color: logoBlue)),
  //                 Icon(Icons.arrow_right, color: logoBlue),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget card(String title, Icon icon123) {
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cardgreycolor)),
      alignment: Alignment.centerRight,
      width: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              fontFamily: "Poppins3",
            ),
          ),
          SizedBox(width: 5),
          icon123 = icon123,
        ],
      ),
    );
  }

  Widget table() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<CustomerDataModel>(
            stream: customerdataaPIbloc.CustomerDataStream,
            builder:
                (context, AsyncSnapshot<CustomerDataModel> customerSnapshot) {
              if (!customerSnapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child:
                          CircularProgressIndicator(color: buttonBlueBorder)),
                );
              }
              // Always use a non-nullable list
              final List<CustomerData> filteredData = (search.length == 0)
                  ? (customerSnapshot.data!.data ?? <CustomerData>[])
                  : (customerSnapshot.data!.data ?? <CustomerData>[])
                      .where((element) =>
                          (element.bookingId ?? '')
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          (element.customerName ?? '')
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          (element.mobileNumber ?? '')
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          (element.garageProfile ?? '')
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          (element.garageId ?? '').contains(search))
                      .toList();

              return filteredData.isEmpty
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
                  : Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(),
                          side: BorderSide(width: 2, color: cardgreycolor2)),
                      child: Center(
                        child: DataTable(
                            showBottomBorder: true,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 10.w,
                            dataRowHeight: 56,
                            dividerThickness: 2,
                            horizontalMargin: 10.h,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'BOOKING ID',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      // textAlign: TextAlign.center,
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'CX NAME',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MOBILE',
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
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'GARAGE',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins4"),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'PROFILE',
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
                                  'SEE FULL DETAILS',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                            rows: List.generate(filteredData.length, (index) {
                              return DataRow(
                                  color:
                                      MaterialStateColor.resolveWith((states) {
                                    return index % 2 == 0
                                        ? Color(0xFFF5FAFF)
                                        : white; //make tha magic!
                                  }),
                                  cells: [
                                    DataCell(Center(
                                      child: Text(
                                        filteredData[index].bookingId ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Text(
                                        filteredData[index]
                                            .customerName
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Text(
                                      filteredData[index].mobileNumber ?? '',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins3"),
                                      textAlign: TextAlign.center,
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child:
                                          filteredData[index].garageProfile !=
                                                      null &&
                                                  filteredData[index]
                                                          .garageProfile !=
                                                      ""
                                              ? Text(filteredData[index]
                                                  .garageProfile!)
                                              : Text("-"),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: logoBlue,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text("View Details"),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => CXData(
                                                        customer_id:
                                                            filteredData[index]
                                                                .customerId
                                                                .toString(),
                                                      )));
                                        },
                                      ),
                                    )))
                                  ]);
                            })),
                      ),
                    );
            }),
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  // Widget button() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8, bottom: 10),
  //     child: RaisedButton(
  //       textColor: Colors.white,
  //       child: Text("View Details"),
  //       color: logoBlue,
  //       onPressed: () {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => CXData()));
  //       },
  //       shape: new RoundedRectangleBorder(
  //         borderRadius: new BorderRadius.circular(10.0),
  //       ),
  //     ),
  //   );
  // }
}
