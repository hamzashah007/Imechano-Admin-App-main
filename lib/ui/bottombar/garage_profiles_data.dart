import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bloc/Garage_details_bloc.dart';
import 'package:imechano_admin/ui/model/Garage_details_model.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styling/image_enlarge.dart';

class GrageProfilesData extends StatefulWidget {
  const GrageProfilesData({Key? key, this.garage_id}) : super(key: key);
  final String? garage_id;
  @override
  _GrageProfilesDataState createState() => _GrageProfilesDataState();
}

class _GrageProfilesDataState extends State<GrageProfilesData> {
  void initState() {
    super.initState();
    // garageProfileAPIBloc.ongarageprofileblocSink();
    garageDeatilsAPIBloc.onGaragedetailsblocSink(widget.garage_id.toString());
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logoBlue,
      appBar: WidgetAppBar(
        title: 'Garage Profiles',
        menuItem: 'assets/svg/Arrow_alt_left.svg',
        // action: 'assets/svg/add.svg',
        // action2: 'assets/svg/Alert.svg'
      ),
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Container(
          margin: EdgeInsets.only(left: 17.w, right: 17.w),
          height: double.infinity,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Container(
            margin: EdgeInsets.only(left: 9.w, right: 9.w, top: 20.h),
            width: double.infinity,
            child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: StreamBuilder<GarageDetailsModel>(
                    stream: garageDeatilsAPIBloc.GarageDetailsStream,
                    builder: (context,
                        AsyncSnapshot<GarageDetailsModel>
                            garageDetailsSnapshot) {
                      if (!garageDetailsSnapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      log('Cr image: ${garageDetailsSnapshot.data!.data!.crImage!}');
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   child: CircleAvatar(
                                  //     radius: 25,
                                  //     backgroundImage:
                                  //         AssetImage("assets/Group 293.png"),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 14.w,
                                  // ),
                                  Text(
                                    "Garage Details",
                                    style: TextStyle(
                                        fontFamily: "Poppins1",
                                        fontSize: 13.sp),
                                  ),
                                  Spacer(),
                                ]),
                            SizedBox(
                              height: 11.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF5FAFF),
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: grayE6E6E5),
                                      bottom: BorderSide(
                                          width: 1, color: grayE6E6E5))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          textTitel('Garage ID :'),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          textTitel('Garage Name :'),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          textTitel('Mobile Number :'),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          textTitel('Email ID :'),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          textTitel('Brands Supported :'),
                                          SizedBox(height: 15.h),
                                          textTitel('City/State :'),
                                          SizedBox(height: 10.h),
                                          textTitel('Cr No :'),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8.h,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.garageId),
                                          SizedBox(height: 15.h),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.garageName),
                                          SizedBox(height: 15.h),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.mobileNumber),
                                          SizedBox(height: 15.h),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.email),
                                          SizedBox(height: 15.h),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.garageProfile),
                                          SizedBox(height: 15.h),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.city),
                                          SizedBox(height: 10.h),
                                          textAns(garageDetailsSnapshot
                                              .data!.data!.crNo),
                                          SizedBox(height: 10.h),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print('Tapped address to open map');
                                      //openMap(20, 20);
                                      openMap(
                                          double.parse(garageDetailsSnapshot
                                              .data!.data!.latitude!),
                                          double.parse(garageDetailsSnapshot
                                              .data!.data!.longitude!));
                                    },
                                    child: Text(
                                      'Address: ${garageDetailsSnapshot.data!.data!.address!}',
                                      style: TextStyle(
                                          fontFamily: "Poppins3",
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "CR Copy",
                                  style: TextStyle(
                                      fontFamily: "Poppins1", fontSize: 13.sp),
                                ),
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 11.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Tapped CR Copy image');
                                showDialog(
                                  context: context,
                                  builder: (_) => ImageDialog(
                                    imageUrl: "https://imechano.com/storage/app/" +
                                        garageDetailsSnapshot.data!.data!
                                            .crImage!, // Replace with your image URL
                                  ),
                                );
                              },
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Image.network(
                                  "https://imechano.com/storage/app/" +
                                      garageDetailsSnapshot
                                          .data!.data!.crImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, object, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      );
                    })),
          ),
        ),
      ),
    );
  }
}
