// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bottombar/create_parts_shops_invoice.dart';
import 'package:imechano_admin/ui/bottombar/parts_shops_invoice.dart';

class PartShopsInvoicePage extends StatefulWidget {
  const PartShopsInvoicePage({Key? key}) : super(key: key);

  @override
  _PartShopsInvoicePageState createState() => _PartShopsInvoicePageState();
}

class _PartShopsInvoicePageState extends State<PartShopsInvoicePage> {
  List jobId = [
    '12210112',
  ];
  List cxName = [
    'Mukesh Bhati',
  ];
  List moNo = [
    '+123-9584651',
  ];
  List garagePro = [
    'Imechano Service',
  ];
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
                          return CreatePartsShopsInvoice();
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
                  'Part Shops Invoice',
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
              // appBar: WidgetAppBar(
              //     title: 'Part Shops Invoice',
              //     menuItem: 'assets/svg/Arrow_alt_left.svg',
              //     // action: 'assets/svg/add.svg',
              //     action2: 'assets/svg/add.svg'),
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

  Widget table() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: cardgreycolor2)),
          child: Center(
            child: DataTable(
              showBottomBorder: true,
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
                        'JOB ID',
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    numeric: false),
                DataColumn(label: _verticalDivider),
                DataColumn(
                    label: Expanded(
                  child: Text(
                    'CX NAME',
                    style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
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
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'NUMBER',
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
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
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'PROFILE',
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
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
                    style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins4"),
                    textAlign: TextAlign.center,
                  ),
                )),
              ],
              rows: List.generate(
                1,
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
                            jobId[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11.sp, fontFamily: "Poppins3"),
                          ),
                        )),
                        DataCell(_verticalDivider),
                        DataCell(Center(
                          child: Text(
                            cxName[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11.sp, fontFamily: "Poppins3"),
                          ),
                        )),
                        DataCell(_verticalDivider),
                        DataCell(Center(
                          child: Text(
                            moNo[index],
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
                                garagePro[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11.sp, fontFamily: "Poppins3"),
                              )
                            ],
                          ),
                        )),
                        DataCell(_verticalDivider),
                        DataCell(button())
                      ]);
                },
              ),
            ),
          ),
        ));
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
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text("View Details"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PartsShopInvoice()));
        },
      ),
    );
  }
}
