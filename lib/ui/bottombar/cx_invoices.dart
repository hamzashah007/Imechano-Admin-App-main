// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/customer_data_bloc.dart';
import 'package:imechano_admin/ui/bottombar/cx_data.dart';
import 'package:imechano_admin/ui/model/customer_data_model.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class CxInvoices extends StatefulWidget {
  const CxInvoices({Key? key, this.customer_id}) : super(key: key);
  final String? customer_id;

  @override
  _CxInvoicesState createState() => _CxInvoicesState();
}

class _CxInvoicesState extends State<CxInvoices> {
  int page = 0;
  List<Data> data = [];
  bool isFinish = false;

  @override
  void initState() {
    customerdataaPIbloc.oncustomerdatablocSink('1');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: WidgetAppBar(
                title: 'Cx Invoices',
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
                      _filterwidget(),
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
          GestureDetector(
            onTap: () {
              page = page - 1;
              customerdataaPIbloc.oncustomerdatablocSink(page.toString());

              setState(() {});
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_left,
                    color: logoBlue,
                  ),
                  Text(
                    "Previous",
                    style: TextStyle(fontSize: 13.sp, color: grayE6E6E5),
                  ),
                ],
              ),
            ),
          ),
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
          GestureDetector(
            onTap: () {
              page = page + 1;
              customerdataaPIbloc.oncustomerdatablocSink(page.toString());

              setState(() {});
            },
            child: Container(
              child: Row(
                children: [
                  Text("Next",
                      style: TextStyle(fontSize: 13.sp, color: logoBlue)),
                  Icon(Icons.arrow_right, color: logoBlue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return customerSnapshot.data!.data!.length == 0
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
                                child: Text(
                                  'See Invoice',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                            rows: List.generate(
                                customerSnapshot.data!.data!.length, (index) {
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
                                        customerSnapshot
                                            .data!.data![index].bookingId!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Text(
                                        customerSnapshot
                                            .data!.data![index].customerName
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Text(
                                      customerSnapshot
                                          .data!.data![index].mobileNumber!,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "Poppins3"),
                                      textAlign: TextAlign.center,
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
                                                            customerSnapshot
                                                                .data!
                                                                .data![index]
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
}
