// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';

import '../../styling/config.dart';
import '../../styling/image_enlarge.dart';
import '../model/garage_invoices_model.dart';

class GarageInvoiceTable extends StatefulWidget {
  const GarageInvoiceTable({Key? key}) : super(key: key);

  @override
  _GarageInvoiceTableState createState() => _GarageInvoiceTableState();
}

class _GarageInvoiceTableState extends State<GarageInvoiceTable> {
  // Step Counter

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

  int current_step = 0;

  List partNo = [
    '1',
    '2',
    '3',
  ];
  List partType = [
    'New Org',
    'Used Org',
    'New Org',
  ];
  List partDesc = ['Breack Liner', 'Spring Liner', 'Ball Joint Cuvk'];
  List qty = [
    '4',
    '2',
    '1',
  ];
  List estCost = [
    '2.000',
    '1.000',
    '4.000',
  ];
  List total = [
    '0.00',
    '0.00',
    '0.00',
  ];

  // List2

  List srNo = [
    '1',
    '2',
  ];
  List workDesc = [
    'Lorem Ipsum is simply dummy text of the',
    'Lorem Ipsum has been the industrys standard dumm',
  ];
  List kwdTotal = [
    'KWD 2000',
    'KWD 2000',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () {
        return Scaffold(
          backgroundColor: logoBlue,
          body: Column(
            children: [
              SizedBox(height: 30.h),
              appBarWidget(),
              Expanded(
                child: Stack(
                  children: [
                    _blankContainer(),
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.only(left: 17.w, right: 17.w),
                        padding: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.disallowIndicator();
                            return true;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.h),
                                Container(
                                  height: 60.h,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/icons/My Account/Group 9252.png"),
                                      )),
                                  margin:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CRNo(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                              height: 30.h,
                                              image: AssetImage(
                                                  "assets/icons/splash/logo.png"),
                                              color: Colors.white),
                                          Text(
                                            "Powered by Company",
                                            style: TextStyle(
                                                fontSize: 5.sp,
                                                color: white,
                                                fontFamily: "Poppins1"),
                                          )
                                        ],
                                      ),
                                      mobileNumber(),
                                    ],
                                  ),
                                ),
                                FutureBuilder<GarageInvoiceModel?>(
                                  future: onGarageProfileApi(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // While waiting for the future to complete, show a loading indicator.
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: buttonBlueBorder),
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
                                      final items = garageInvoiceModel.data;

                                      log(items![0].garageInvoice!);
                                      return Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 20.w,
                                                  top: 10.h,
                                                  right: 20),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Garage Details",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontFamily:
                                                              "Poppins1"),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Divider(
                                              color: grayE6E6E5,
                                              indent: 10,
                                              endIndent: 10),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 15.w, right: 15.w),
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        "assets/Group 9033.png"),
                                                    height: 54.h,
                                                  ),
                                                  SizedBox(width: 15.h),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Details(
                                                              "Booking ID :"),
                                                          SizedBox(
                                                              height: 10.h),
                                                          Details(
                                                              "Garage Name :"),
                                                          SizedBox(
                                                              height: 10.h),
                                                          Details("CX ID :"),
                                                          SizedBox(
                                                              height: 10.h),
                                                          Details("Car Plate:"),
                                                        ],
                                                      ),
                                                      SizedBox(width: 10.h),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          DetailsSubtitle(
                                                              items[0]
                                                                  .bookingId!),
                                                          SizedBox(
                                                              height: 10.h),
                                                          DetailsSubtitle(
                                                              items[0]
                                                                  .garageName!),
                                                          SizedBox(
                                                              height: 10.h),
                                                          DetailsSubtitle(
                                                              items[0]
                                                                  .customerId!),
                                                          SizedBox(
                                                              height: 10.h),
                                                          DetailsSubtitle(
                                                              items[0]
                                                                  .carPlateNo!),
                                                          // SizedBox(
                                                          //     height: 10.h),
                                                          // SizedBox(
                                                          //     height: 10.h),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                              color: grayE6E6E5,
                                              indent: 10,
                                              endIndent: 10),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // SizedBox(
                                                //   height: 10,
                                                // ),
                                                Text(
                                                  "Garage Invoice",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins1",
                                                      fontSize: 13.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => ImageDialog(
                                                  imageUrl: Config.imageurl +
                                                      items[0]
                                                          .garageInvoice!, // Replace with your image URL
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 200,
                                              width: 200,
                                              child: Image.network(
                                                Config.imageurl +
                                                    items[0].garageInvoice!,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, object, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          )
                                        ],
                                      );
                                    }
                                  },
                                ),
                                Divider(
                                    color: grayE6E6E5,
                                    indent: 10,
                                    endIndent: 10),
                                SizedBox(height: 10.h),
                                SizedBox(height: 10.h),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget appBarWidget() {
    return Container(
        height: 120.h,
        color: logoBlue,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(17),
                      child: SvgPicture.asset('assets/svg/Arrow_alt_left.svg')),
                ),
                SizedBox(
                  width: 23.w,
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Garage Invoice",
                        style: TextStyle(
                          color: white,
                          fontSize: 18.sp,
                          fontFamily: "Poppins1",
                        ),
                      )),
                ),
                Row(
                  children: [
                    // Container(
                    //     padding:
                    //         EdgeInsets.only(top: 15, right: 10, bottom: 15),
                    //     child: SvgPicture.asset("assets/svg/add.svg",
                    //         height: 15, width: 15, color: white)),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Get.to(NotificationScreen());
                    //   },
                    //   child: Container(
                    //       padding: EdgeInsets.only(
                    //           top: 20, right: 17, bottom: 20, left: 13),
                    //       child: SvgPicture.asset(
                    //         "assets/svg/Alert.svg",
                    //       )),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget _blankContainer() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: logoBlue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0.w),
            bottomRight: Radius.circular(100.0.w)),
      ),
    );
  }

  Widget table() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showBottomBorder: true,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xff162e3f)),
          columnSpacing: 25.w,
          dataRowHeight: 50.h,
          horizontalMargin: 10.w,
          columns: [
            DataColumn(
                label: Expanded(
                  child: Text(
                    'Part\nNo.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                numeric: false),
            DataColumn(
              label: Expanded(
                child: Text('Part\nType',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        fontFamily: "Poppins1")),
              ),
            ),
            DataColumn(
                label: Expanded(
              child: Text('Part\nDesc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Qty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Est\nCost',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
          ],
          rows: List.generate(
            3,
            (index) {
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) {
                    return index % 2 == 0
                        ? Color(0xFFF5FAFF)
                        : white; //make tha magic!
                  }),
                  cells: [
                    DataCell(Center(
                      child: Text(partNo[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.sp, fontFamily: "Poppins3")),
                    )),
                    DataCell(Center(
                      child: Text(partType[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.sp, fontFamily: "Poppins3")),
                    )),
                    DataCell(Center(
                      child: Text(
                        partDesc[index],
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        qty[index],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        estCost[index],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        total[index],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                      ),
                    )),
                  ]);
            },
          ),
        ));
  }

  Widget tableSecond() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: DataTable(
            showBottomBorder: true,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Color(0xff162e3f)),
            columnSpacing: 10.w,
            dataRowHeight: 50.h,
            horizontalMargin: 10.w,
            columns: [
              DataColumn(
                  label: Expanded(
                    child: Text(
                      'Sr\nNo.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins1",
                          fontSize: 11.sp),
                    ),
                  ),
                  numeric: false),
              DataColumn(
                label: Text(
                  'Labour Work\nDescription',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp),
                ),
              ),
              DataColumn(
                  label: Expanded(
                child: Text(
                  'Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp),
                ),
              )),
            ],
            rows: List.generate(
              2,
              (index) {
                return DataRow(cells: [
                  DataCell(
                    Text(
                      srNo[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                    ),
                  ),
                  DataCell(Text(
                    workDesc[index],
                    style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                  )),
                  DataCell(Text(
                    kwdTotal[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                  )),
                ]);
              },
            ),
          ),
        ));
  }

  Widget CRNo() {
    return Container(
      child: Text(
        "CR No.\n1232334654654",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w600),
      ),
      margin: EdgeInsets.only(right: 8.w),
    );
  }

  Widget mobileNumber() {
    return Container(
      margin: EdgeInsets.only(
        left: 8.w,
      ),
      child: Text(
        "Telephone No.\n+9125-2543-25",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget customerDetails() {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Details",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/icons/My Vehicle/Group 9254.png"),
                height: 70.h,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name:          Mustufa Khan"),
                    Text("Address:      dsfgsdfsdfsdfsdf"),
                    Text("City/State:   Dubai        ")
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget carDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          image: AssetImage("assets/icons/My Vehicle/Group 9253.png"),
          height: 70.h,
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Make:          Mustufa Khan"),
              Text("Model:        dsfgsdfsdfsdfsdf"),
              Text("Year:           2021        "),
              Text("Mileage:     20 KMH        ")
            ],
          ),
        )
      ],
    );
  }

  Widget estBalance() {
    return Container(
      margin: EdgeInsets.only(left: 120.w),
      height: 40.h,
      width: 167.w,
      //padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
      alignment: Alignment.center,
      color: Color(0xffdde2f5),
      child: Text(
        "Est Balance: KWD 2.000",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins1", fontSize: 11.sp),
      ),
    );
  }

  Widget totalLabour() {
    return Container(
      margin: EdgeInsets.only(left: 120.w),
      height: 40.h,
      width: 167.w,
      alignment: Alignment.center,
      color: Color(0xffdde2f5),
      child: Text(
        "Total Labour: KWD 10.000",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins1", fontSize: 11.sp),
      ),
    );
  }

  Widget totalPart() {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(6.w)),
      height: 40.h,
      width: 167.w,
      alignment: Alignment.center,
      color: Color(0xffdde2f5),
      child: Text(
        "Total Part: KWD 10.000",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins1", fontSize: 11.sp),
      ),
    );
  }

  Widget Details(String title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: "Poppins3",
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }

  Widget DetailsSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
          fontFamily: "Poppins3",
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }
}
