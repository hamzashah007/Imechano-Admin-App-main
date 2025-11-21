import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';

import '../shared/widgets/appbar/custom_appbar_widget.dart';

class ProgressReportActive extends StatefulWidget {
  const ProgressReportActive({Key? key}) : super(key: key);

  @override
  _ProgressReportActiveState createState() => _ProgressReportActiveState();
}

class _ProgressReportActiveState extends State<ProgressReportActive> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: WidgetAppBar(
                title: 'Progress Report',
                menuItem: 'assets/svg/Arrow_alt_left.svg',
                // action: 'assets/svg/shopping-cart.svg',
                // action2: 'assets/svg/ball.svg'
              ),
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'BMW',
                          style: TextStyle(fontFamily: "Poppins2"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 63),
                        child: Image.asset(
                          "assets/2021-BMW.png",
                          height: 130,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Image.asset("assets/Group 9247.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Oil Filter Change",
                              style: TextStyle(
                                  fontFamily: "poppins1", fontSize: 12),
                            ),
                            Text(
                              "Engine Service",
                              style: TextStyle(
                                  fontFamily: "poppins1", fontSize: 12),
                            ),
                            Text(
                              "Battery Service",
                              style: TextStyle(
                                  fontFamily: "poppins1", fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Date:28-10-2021",
                                  style: TextStyle(
                                      fontFamily: "poppins1", fontSize: 10),
                                ),
                                Text(
                                  "Time:10:00 AM",
                                  style: TextStyle(
                                      fontFamily: "poppins1", fontSize: 10),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Date:28-10-2021",
                                  style: TextStyle(
                                      fontFamily: "poppins1", fontSize: 10),
                                ),
                                Text(
                                  "Time:12:00PM",
                                  style: TextStyle(
                                      fontFamily: "poppins1", fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                          height: 0.5,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Service Details',
                          style:
                              TextStyle(fontFamily: "poppins2", fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Engnie",
                            style: TextStyle(fontFamily: "poppins2")),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 15.w,
                          bottom: 15.w,
                        ),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 13.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_outline_sharp,
                                      color: presenting,
                                    ),
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        color: presenting,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      '250 Ratings',
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.w, top: 15.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 10.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Takes 4 Hour',
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Every 6 Months or 5000 kms',
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "KDW 4.000",
                                      style: TextStyle(
                                          fontFamily: "poppins1",
                                          fontSize: 15,
                                          color: red),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Alignment & Balancing Included',
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Wheel Rotation Inlcluded',
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  "KDW 4.000",
                                  style: TextStyle(
                                      fontFamily: "poppins1",
                                      fontSize: 15,
                                      color: red),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
