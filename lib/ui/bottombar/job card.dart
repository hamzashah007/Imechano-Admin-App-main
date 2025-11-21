// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class JobCard extends StatefulWidget {
  const JobCard({Key? key, this.carcondition, this.workneeded, this.image})
      : super(key: key);
  final String? carcondition;
  final String? workneeded;
  final String? image;
  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  TextEditingController jobNo = TextEditingController();
  TextEditingController jobDate = TextEditingController();
  TextEditingController carRegNumber = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController mileage = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController carMake = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerContactNo = TextEditingController();
  TextEditingController vinNumber = TextEditingController();
  TextEditingController garageName = TextEditingController();
  String? selectedValue;

  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  bool isSwitch = true;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 830),
      builder: () => Scaffold(
          // backgroundColor: Color(0xff70bdf1),
          appBar: WidgetAppBar(
            title: 'Car Condition Details',
            menuItem: 'assets/svg/Arrow_alt_left.svg',
            // imageicon: 'assets/svg/Arrow_alt_left.svg',
            // action: 'assets/svg/add.svg',
            // action2: 'assets/svg/Alert.svg'
          ),
          body: SafeArea(
            child: Column(children: [
              Container(
                  // height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0))),
                  child: Frontbumber("Front Bumber Uploaded Image")),
              // Expanded(
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Container(
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(25.0),
              //         topLeft: Radius.circular(25.0))),
              //         child:
              //             NotificationListener<OverscrollIndicatorNotification>(
              //           onNotification: (notification) {
              //             notification.disallowGlow();
              //             return true;
              //           },
              //           child: SingleChildScrollView(
              //             child: Column(
              //               children: [
              //                 // SizedBox(
              //                 //   height: 15.h,
              //                 // ),
              //                 // Row(
              //                 //   mainAxisAlignment:
              //                 //       MainAxisAlignment.spaceEvenly,
              //                 //   children: [
              //                 //     textFiled("Job No.", jobNo),
              //                 //     textFiled("Job Date", jobDate),
              //                 //   ],
              //                 // ),
              //                 // Row(
              //                 //   mainAxisAlignment:
              //                 //       MainAxisAlignment.spaceEvenly,
              //                 //   children: [
              //                 //     textFiled(
              //                 //         "Car Registarion no.", carRegNumber),
              //                 //     textFiled("Year", year),
              //                 //   ],
              //                 // ),
              //                 // Row(
              //                 //   mainAxisAlignment:
              //                 //       MainAxisAlignment.spaceEvenly,
              //                 //   children: [
              //                 //     textFiled("Milage", mileage),
              //                 //     textFiled("Date/Time in.", dateTime),
              //                 //   ],
              //                 // ),
              //                 // Row(
              //                 //   mainAxisAlignment:
              //                 //       MainAxisAlignment.spaceEvenly,
              //                 //   children: [
              //                 //     textFiled("Car Make", carMake),
              //                 //     textFiled("Car Model", carModel),
              //                 //   ],
              //                 // ),
              //                 // Row(
              //                 //   mainAxisAlignment:
              //                 //       MainAxisAlignment.spaceEvenly,
              //                 //   children: [
              //                 //     textFiled("Customer name", customerName),
              //                 //     textFiled(
              //                 //         "Cutomer Contact no", customerContactNo),
              //                 //   ],
              //                 // ),
              //                 // Row(
              //                 //   mainAxisAlignment:
              //                 //       MainAxisAlignment.spaceEvenly,
              //                 //   children: [
              //                 //     textFiled("VIN No.", vinNumber),
              //                 //     textFiledDrop("Garage name", garageName),
              //                 //   ],
              //                 // ),
              //                 // Row(
              //                 //     mainAxisAlignment:
              //                 //         MainAxisAlignment.spaceEvenly,
              //                 //     children: [
              //                 //       VINTextfiled(
              //                 //           "assets/icons/jobcard/Mask Group 10_.png"),
              //                 //       VINTextfiled(
              //                 //           "assets/icons/jobcard/Mask Group 10_1.png"),
              //                 //     ]),
              //                 // ReportTextfiled(),
              //                 // SizedBox(
              //                 //   height: 10.h,
              //                 // ),
              //                 // Divider(
              //                 //   thickness: 10.h,
              //                 // ),
              //                 Frontbumber("Front Bumber Uploaded Image"),
              //                 // Frontbumber("Front Left Panel Uploded Images"),
              //                 // SizedBox(height: 70.h)
              //               ],
              //             ),
              //           ),
              //         ),
              //       )),
              //     ],
              //   ),
              // ),
            ]),
          )),
    );
  }

  Widget VINTextfiled(String image) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      height: 89.h,
      child: SizedBox(
        width: 175.w,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Image(height: 50.h, image: AssetImage("$image")),
        ),
      ),
    );
  }

  Widget ReportTextfiled() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                left: 22.w, bottom: 10.h, top: 10.h, right: 22.w),
            height: 89.h,
            //width: 200.w,
            child: SizedBox(
              width: 160.w,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: cardgreycolor),
                  ),
                  hintText: "Report Defect type....",
                  hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                  // fillColor: cardgreycolor,
                  // filled: true
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget carImage(String image) {
    return Container(
      margin: EdgeInsets.all(5.h),
      decoration: BoxDecoration(border: Border.all(color: grayE6E6E5)),
      child: Image(height: 50.h, image: FileImage(File(image))),
    );
  }

  Widget bottomCard() {
    return Expanded(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Pickup Condition",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(widget.carcondition.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Pickup Condition",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(widget.workneeded.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
      ],
    ));
  }

  Widget Frontbumber(String title) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffa9d7f7)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10),
            child: Text(
              "$title",
              style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                carImage(widget.image.toString()),
                carImage(widget.image.toString()),
                carImage(widget.image.toString()),
              ],
            ),
          ),
          Row(
            children: [
              bottomCard(),
            ],
          )
        ],
      ),
    );
  }

  Widget textFiled(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true),
      ),
    );
  }

  Widget textFiledDrop(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
        ),
      ),
    );
  }
}
