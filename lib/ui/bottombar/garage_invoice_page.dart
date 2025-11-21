// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/bottombar/add_garage_invoice.dart';
import 'package:imechano_admin/ui/bottombar/garage_invoice_table.dart';
import 'package:imechano_admin/ui/model/garage_invoices_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../model/garage_profile_model.dart';

class GarageInvoicePage extends StatefulWidget {
  const GarageInvoicePage({Key? key}) : super(key: key);

  @override
  _GarageInvoicePageState createState() => _GarageInvoicePageState();
}

class _GarageInvoicePageState extends State<GarageInvoicePage> {
  final _GarageProfile = PublishSubject<GarageProfileModel>();
  String search = "";

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
                    borderRadius: BorderRadius.circular(40),
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
        ],
      ),
    );
  }

  Future<GarageInvoiceModel?> onGarageProfileApi() async {
    try {
      final strURL = Uri.parse(Config.apiurl + 'garage-invoice');

      final response = await http.post(strURL, headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return GarageInvoiceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: AppBar(
                leading: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, left: 17),
                          child: SvgPicture.asset(
                              'assets/svg/Arrow_alt_left.svg')),
                    ),
                  ],
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return AddGarageInvoice();
                        },
                      ));
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 16, right: 15, bottom: 15, left: 10),
                        child: SvgPicture.asset("assets/svg/add.svg",
                            color: Colors.white, height: 20.h, width: 20.w)),
                  ),
                ],
                title: Text(
                  'Garage Invoices',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Poppins1',
                    color: Colors.white,
                  ),
                ),
                // backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
                backgroundColor: logoBlue,
                centerTitle: true,
                elevation: 0,
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
                      _searchfilterwidget(),
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

  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          SizedBox(width: 3.h),
          VerticalDivider(),
          SizedBox(width: 3.h),
          card(
              "Filter",
              Icon(
                Icons.filter_list_alt,
                size: 17,
                color: logoBlue,
              )),
          SizedBox(width: 3.h),
          VerticalDivider(),
          SizedBox(width: 3.h),
          card("Short", Icon(Icons.filter_list, size: 17, color: logoBlue)),
          SizedBox(width: 3.h),
          VerticalDivider(),
          SizedBox(width: 3.h),
          Center(
              child: Text("Next",
                  style: TextStyle(fontSize: 13.sp, color: logoBlue))),
          Icon(Icons.arrow_right, color: logoBlue),
        ],
      ),
    );
  }

  Widget card(String title, Icon icon123) {
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cardgreycolor)),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 3),
      width: 75,
      child: Row(
        children: [
          new Text(
            title,
            style: TextStyle(fontFamily: "Poppins3", fontSize: 11.sp),
          ),
          icon123 = icon123,
        ],
      ),
    );
  }

  Widget table() {
    return FutureBuilder<GarageInvoiceModel?>(
      future: onGarageProfileApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator.
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If an error occurs, display an error message.
          return Center(
            child: Text('Error fetching data'),
          );
        } else {
          // If the future has completed successfully, display the data in a list.
          final garageInvoiceModel = snapshot.data;
          if (garageInvoiceModel == null) {
            // Handle the case when data is null (response not successful).
            return Center(
              child: Text('No data available'),
            );
          }
          // Assuming you have a list of items inside GarageInvoiceModel
          var items = garageInvoiceModel.data;

          if (search.length == 0) {
            items = garageInvoiceModel.data;
          } else {
            items = items!
                .where((element) =>
                    element.bookingId!.contains(search) ||
                    element.garageName!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    element.customerId!.contains(search) ||
                    element.carPlateNo!.contains(search))
                .toList();
          }

          if (search.length == 0) {}
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: cardgreycolor2)),
                child: Center(
                  child: DataTable(
                    showBottomBorder: false,
                    headingRowColor:
                        MaterialStateColor.resolveWith((states) => white),
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
                                  fontSize: 11.sp, fontFamily: "Poppins4"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          numeric: false),
                      DataColumn(label: _verticalDivider),
                      DataColumn(
                          label: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'GARAGE',
                              style: TextStyle(
                                  fontSize: 11.sp, fontFamily: "Poppins4"),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'NAME',
                              style: TextStyle(
                                  fontSize: 11.sp, fontFamily: "Poppins4"),
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
                              'CX  ',
                              style: TextStyle(
                                  fontSize: 11.sp, fontFamily: "Poppins4"),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'ID',
                              style: TextStyle(
                                  fontSize: 11.sp, fontFamily: "Poppins4"),
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
                              'CAR PLATE',
                              style: TextStyle(
                                  fontSize: 11.sp, fontFamily: "Poppins4"),
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
                    rows: List.generate(
                      items!.length,
                      (index) {
                        return DataRow(
                            color: MaterialStateColor.resolveWith((states) {
                              return index % 2 == 0
                                  ? Color(0xFFF5FAFF)
                                  : white; //make tha magic!
                            }),
                            cells: [
                              DataCell(Center(
                                child: Text(
                                  items![index].bookingId!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins3"),
                                ),
                              )),
                              DataCell(_verticalDivider),
                              DataCell(Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      items[index].garageName!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins3"),
                                    ),
                                  ],
                                ),
                              )),
                              DataCell(_verticalDivider),
                              DataCell(Text(
                                items[index].customerId!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11.sp, fontFamily: "Poppins3"),
                              )),
                              DataCell(_verticalDivider),
                              DataCell(Center(
                                  child: Text(
                                items[index].carPlateNo!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11.sp, fontFamily: "Poppins3"),
                              ))),
                              DataCell(_verticalDivider),
                              DataCell(button())
                            ]);
                      },
                    ),
                  ),
                ),
              ));
        }
      },
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget button() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: logoBlue,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text("View Details"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GarageInvoiceTable()));
        },
      ),
    );
  }
}
