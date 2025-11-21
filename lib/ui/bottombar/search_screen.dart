// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/ui/bottombar/Reports%20Screen/paid_order.dart';
import 'package:imechano_admin/ui/bottombar/Reports%20Screen/ready_del.dart';
import 'package:imechano_admin/ui/bottombar/Reports%20Screen/today_count.dart';
import 'package:imechano_admin/ui/bottombar/total_customer.dart';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/ui/model/reports_model.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

import 'Reports Screen/average_ticket_size.dart';
import 'Reports Screen/conversation.dart';
import 'Reports Screen/emergency_screen.dart';
import 'Reports Screen/inquiry.dart';
import 'Reports Screen/open_order.dart';
import 'Reports Screen/work_progress.dart';
import 'Reports Screen/workshop.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ReportsModel? reports;

  Future<ReportsModel?> reportsApi() async {
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
      return null;
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

  List subtitle = [
    "Total Customer",
    "Average Ticket Size",
    "Conversion",
    "Open Orders",
    "At Workshop",
    "Work in Process",
    "Ready for Delivery",
    "Paid\nOrder",
    "Today's Count",
    "Inquiry",
    "Emergency"
  ];

  final List<bool> _selected = List.generate(11, (i) => false);

  List page = [
    TotalCustomerPage(),
    Averageticket(),
    Conversion(),
    Openorder(),
    WorkshopScreen(),
    Workprogress(),
    Readydelivery(),
    PaidOrder(),
    TodayCount(),
    InquiryScreen(),
    EmergencyScreen()
  ];
  bool isSwitch = true;

  bool Isselected = false;
  List title = [];
  @override
  Widget build(BuildContext context) {
    print(reports?.reports?.averageTicketSizeComplete!.toString());
    title = [
      reports?.reports?.customerCount!.toString(),
      reports?.reports?.averageTicketSize?.toString(),
      reports?.reports?.conversions.toString(),
      reports?.reports?.openOrders.toString(),
      reports?.reports?.atWorkShop.toString(),
      reports?.reports?.gvm.toString(),
      reports?.reports?.readyForDelivery.toString(),
      reports?.reports?.readyForDelivery.toString(),
      "11",
      reports?.reports?.todayCount.toString(),
      "8",
      reports?.reports?.emergencyCount.toString(),
    ];

    return Scaffold(
        backgroundColor: Color(0xff70bdf1),
        appBar: WidgetAppBar(
            title: 'Reports', menuItem: 'assets/svg/Arrow_alt_left.svg'),
        body: SafeArea(
          child: ScreenUtilInit(
            designSize: Size(414, 896),
            builder: () => Column(children: [
              SizedBox(height: 12.h),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(top: 16.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0))),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 2.h),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 15.w, right: 15.w),
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                decoration: BoxDecoration(
                                    color: logoBlue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          card(
                                              reports != null
                                                  ? reports!
                                                      .reports!.customerCount
                                                      .toString()
                                                  : "",
                                              "Total Customer"),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: card(
                                                  reports != null
                                                      ? reports!.reports!
                                                          .averageTicketSize
                                                          .toString()
                                                      : "",
                                                  "Avg. Ticket Size")),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: card(
                                                  reports != null
                                                      ? reports!
                                                          .reports!.conversions
                                                          .toString()
                                                      : "",
                                                  "Conversation")),
                                          SizedBox(width: 135.w),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Divider(thickness: 10),
                              SizedBox(height: 10.h),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Our Services",
                                      style: TextStyle(
                                          fontFamily: "Poppins1",
                                          fontSize: 15.sp),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 10.w,
                                            right: 10.w,
                                            top: 3,
                                            bottom: 3),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: grayE6E6E5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          children: [
                                            Text("Filter",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Poppins3')),
                                            Icon(Icons.filter_alt_rounded,
                                                color: Color(0xff1840db),
                                                size: 18.sp)
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              _Gridcard(reports)
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Widget _Gridcard(var data) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 11,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 15),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (() {
            print('Tapped Grid item at index: ' + index.toString());
            // setState(() {
            //   _selected[index] = !_selected[index];
            // });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page[index]));
            // if (_selected[index] == true) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => page[index])
            //       );
            // }
          }),
          child: Container(
            decoration: BoxDecoration(
              // color: Isselected ? Color(0xffDEEFFC) : Colors.transparent,
              // color: _selected[index] ? Color(0xffDEEFFC) : null,
              border: Border.all(
                  width: 1, color: Isselected ? Color(0xff70BDF1) : grayE6E6E5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title[index] != null ? title[index] : "",
                    style: TextStyle(fontSize: 17.sp, fontFamily: "Poppins1"),
                  ),
                  Text(
                    subtitle[index],
                    style: TextStyle(fontSize: 13.sp, fontFamily: "Poppins3"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget card(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: TextStyle(
                color: white,
                fontSize: 16.sp,
                fontFamily: "Poppins4",
                fontWeight: FontWeight.w600),
          ),
          Text(
            "$subtitle",
            style: TextStyle(
              color: white,
              fontSize: 11.5.sp,
              fontFamily: "Poppins3",
            ),
          )
        ],
      ),
    );
  }

  Widget searchTextfiled() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 15.w, right: 15.w),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: 'Search Services...',
            hintStyle: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(7),
          ),
        ),
      ),
    );
  }

  Widget Itemcard(int number, String title) {
    return Column(
      children: [
        GridView.builder(
            itemCount: 10,
            //itemCount: allcategorysnapshot.data!.data!.length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print('Tapped List item at index: ' + index.toString());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => page[index]));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [
                    //   new BoxShadow(
                    //     color: Colors.grey,
                    //     blurRadius: 1.0,
                    //   ),
                    // ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$number',
                        style: TextStyle(
                            fontFamily: "Poppins1", color: Color(0xff1840db)),
                      ),
                      // Image.network(
                      //   allcategorysnapshot.data!.data![index].icon!,
                      //   height: ScreenUtil().setHeight(50),
                      //   width: ScreenUtil().setWidth(50),
                      // ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "$title",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 11.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
