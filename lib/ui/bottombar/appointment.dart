// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:imechano_admin/styling/colors.dart';
// import 'package:imechano_admin/ui/bloc/appoiement_details_bloc.dart';
// import 'package:imechano_admin/ui/model/appoinment_details_model.dart';
// import 'package:imechano_admin/ui/model/appoinment_details_model.dart';
// import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class Appointment extends StatefulWidget {
//   final String? id;
//   final String? appoiement_id;

//   const Appointment({Key? key, this.id, this.appoiement_id}) : super(key: key);

//   @override
//   _AppointmentState createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // garageProfileAPIBloc.ongarageprofileblocSink();
//     print("appointment details page");
//     print(widget.appoiement_id.toString());
//     appoinmentDeatilsAPIBloc
//         .onappoinmentdetailsblocSink(widget.appoiement_id.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: Size(414, 896),
//         builder: () => Scaffold(
//               backgroundColor: logoBlue,
//               appBar: WidgetAppBar(
//                 title: 'Appointments',
//                 menuItem: 'assets/svg/Arrow_alt_left.svg',
//                 // action: 'assets/svg/add.svg',
//                 // action2: 'assets/svg/Alert.svg'
//               ),
//               body: ScreenUtilInit(
//                 designSize: Size(414, 896),
//                 builder: () => Container(
//                   margin: EdgeInsets.only(left: 12, right: 12),
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                       color: white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20))),
//                   child: StreamBuilder<AppoinmentDetailsModel>(
//                       stream: appoinmentDeatilsAPIBloc.AppoinmentDetailsStream,
//                       builder: (context,
//                           AsyncSnapshot<AppoinmentDetailsModel>
//                               appoinmentdetailsSnapshot) {
//                         print("appoinmentdetailsSnapshot data");
//                         // print(appoinmentdetailsSnapshot.data);
//                         if (!appoinmentdetailsSnapshot.hasData) {
//                           return Center(
//                             child: appoinmentdetailsSnapshot.data == null
//                                 ? Text(
//                                     'No Data Found',
//                                     style: TextStyle(
//                                         fontFamily: 'Poppins1',
//                                         fontSize: 18.sp),
//                                   )
//                                 : CircularProgressIndicator(),
//                           );
//                         } else {
//                           print("DATA FOUND ---------------");
//                           print(appoinmentdetailsSnapshot.data!.data!.bookingId
//                               .toString());
//                         }
//                         return Container(
//                           margin: EdgeInsets.only(left: 6, right: 6, top: 10),
//                           width: double.infinity,
//                           child: NotificationListener<
//                               OverscrollIndicatorNotification>(
//                             onNotification: (notification) {
//                               notification.disallowGlow();
//                               return true;
//                             },
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           child: CircleAvatar(
//                                             radius: 25,
//                                             backgroundImage: AssetImage(
//                                                 "assets/Group 293.png"),
//                                           ),
//                                         ),
//                                         SizedBox(width: 14.w),
//                                         Text(
//                                           "Garage Details",
//                                           style: TextStyle(
//                                               fontFamily: "Poppins1",
//                                               fontSize: 13.sp),
//                                         ),
//                                         //SizedBox(width: 10),
//                                         Spacer(),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8.0),
//                                           child: Container(
//                                             height: 40.h,
//                                             child: OutlinedButton(
//                                               style: OutlinedButton.styleFrom(
//                                                 side: BorderSide(
//                                                   width: 1.0,
//                                                   color: logoBlue,
//                                                   style: BorderStyle.solid,
//                                                 ),
//                                               ),
//                                               onPressed: () {
//                                                 print("downloading...");
//                                                 // Fluttertoast.showToast(
//                                                 //     msg: "This is Center Short Toast",
//                                                 //     toastLength: Toast.LENGTH_SHORT,
//                                                 //     gravity: ToastGravity.CENTER,
//                                                 //     timeInSecForIosWeb: 1,
//                                                 //     backgroundColor: Colors.red,
//                                                 //     textColor: Colors.black,
//                                                 //     fontSize: 16.0
//                                                 // );
//                                                 createPDF(
//                                                     appoinmentdetailsSnapshot);
//                                               },
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     "Downloads",
//                                                     style: TextStyle(
//                                                         color: logoBlue,
//                                                         fontSize: 13.sp,
//                                                         fontFamily: "Poppins1"),
//                                                   ),
//                                                   SizedBox(width: 5.w),
//                                                   SvgPicture.asset(
//                                                       "assets/svg/Import.svg")
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                   SizedBox(
//                                     height: 11.h,
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsets.only(left: 20, right: 20),
//                                     decoration: BoxDecoration(
//                                         color: Color(0xFFF5FAFF),
//                                         border: Border(
//                                             top: BorderSide(
//                                                 width: 1, color: grayE6E6E5),
//                                             bottom: BorderSide(
//                                                 width: 1, color: grayE6E6E5))),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             textTitel('Booking ID :'),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             textTitel('Garage Name'),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             textTitel('Brand :'),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             textTitel('Email ID :'),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             textTitel('Phone Number :'),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             textTitel('Address :'),
//                                             SizedBox(
//                                               height: 15.h,
//                                             ),
//                                             textTitel('City/State :'),
//                                             SizedBox(height: 10.h),
//                                           ],
//                                         ),
//                                         Container(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!.data!.bookingId
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 15.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .garageDetails!
//                                                   .garageName
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 15.h,
//                                               ),
//                                               textAns(''),
//                                               SizedBox(
//                                                 height: 15.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .garageDetails!
//                                                   .email
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 15.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .garageDetails!
//                                                   .mobileNumber
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 15.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .garageDetails!
//                                                   .address
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 15.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .garageDetails!
//                                                   .city
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Row(children: [
//                                     Container(
//                                       child: CircleAvatar(
//                                         radius: 25,
//                                         backgroundImage:
//                                             AssetImage("assets/Group 9382.png"),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 14.w,
//                                     ),
//                                     Text(
//                                       "Car Information",
//                                       style: TextStyle(
//                                           fontFamily: "Poppins1",
//                                           fontSize: 13.sp),
//                                     ),
//                                     Spacer(),
//                                   ]),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Container(
//                                     width: double.infinity,
//                                     padding:
//                                         EdgeInsets.only(left: 20, right: 20),
//                                     decoration: BoxDecoration(
//                                         color: Color(0xFFF5FAFF),
//                                         border: Border(
//                                             top: BorderSide(
//                                                 width: 1, color: grayE6E6E5),
//                                             bottom: BorderSide(
//                                                 width: 1, color: grayE6E6E5))),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             textTitel('Car Model :'),
//                                             // SizedBox(
//                                             //   height: 13.h,
//                                             // ),
//                                             // textTitel('Make :'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                             textTitel('Year:'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                             textTitel('Mileage:'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                             textTitel('Cylinder:'),
//                                             SizedBox(height: 10.h),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 40),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!.data!.carDetails!.model
//                                                   .toString()),
//                                               // SizedBox(
//                                               //   height: 13.h,
//                                               // ),
//                                               // textAns(appoinmentdetailsSnapshot
//                                               //     .data!.data!.carDetails!.model
//                                               //     .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .carDetails!
//                                                   .modelYear
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .carDetails!
//                                                   .mileage
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .carDetails!
//                                                   .cylinder
//                                                   .toString()),
//                                               SizedBox(height: 8.h)
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Row(children: [
//                                     Container(
//                                       child: CircleAvatar(
//                                         radius: 25,
//                                         backgroundImage:
//                                             AssetImage("assets/Group 9382.png"),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 14.w,
//                                     ),
//                                     Text(
//                                       "Pickup Schedule Details",
//                                       style: TextStyle(
//                                           fontFamily: "Poppins1",
//                                           fontSize: 13.sp),
//                                     ),
//                                     Spacer(),
//                                   ]),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Container(
//                                     width: double.infinity,
//                                     padding:
//                                         EdgeInsets.only(left: 20, right: 20),
//                                     decoration: BoxDecoration(
//                                         color: Color(0xFFF5FAFF),
//                                         border: Border(
//                                             top: BorderSide(
//                                                 width: 1, color: grayE6E6E5),
//                                             bottom: BorderSide(
//                                                 width: 1, color: grayE6E6E5))),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             textTitel('Pickup Id:'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                             textTitel('CX Name:'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                             textTitel('Email:'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                             textTitel('address:'),
//                                             SizedBox(
//                                               height: 13.h,
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 40),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 10.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!.data!.pickupDetails!.id
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .pickupDetails!
//                                                   .name
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .pickupDetails!
//                                                   .email
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                               textAns(appoinmentdetailsSnapshot
//                                                   .data!
//                                                   .data!
//                                                   .pickupDetails!
//                                                   .address
//                                                   .toString()),
//                                               SizedBox(
//                                                 height: 13.h,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 20.h,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               ),
//             ));
//   }

//   Widget textTitel(title) {
//     return Text(
//       title,
//       style: TextStyle(
//           fontFamily: "Poppins3",
//           color: Colors.grey,
//           fontWeight: FontWeight.w600,
//           fontSize: 11.sp),
//     );
//   }

//   Widget textAns(ans) {
//     return Text(
//       ans,
//       style: TextStyle(
//           fontFamily: "Poppins3",
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//           fontSize: 11.sp),
//     );
//   }

//   Future<void> createPDF(
//       AsyncSnapshot<AppoinmentDetailsModel> appoinmentdetailsSnapshot) async {
//     final pdf = pw.Document();

//     // pdf.addPage(
//     //   pw.Page(
//     //     build: (pw.Context context) => pw.Center(
//     //       child: pw.Text("Booking ID: "+appoinmentdetailsSnapshot
//     //           .data!.data!.bookingId
//     //           .toString()),
//     //     ),
//     //   ),
//     // );

//     pdf.addPage(pw.Page(
//       build: (context) {
//         return pw.Row(
//           children: [
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.SizedBox(
//                   height: 10.h,
//                 ),
//                 pw.Text('Booking ID :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Garage Name'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Email ID :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Phone Number :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Address :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('City/State :'),
//                 pw.SizedBox(height: 10.h),
//               ],
//             ),
//             pw.Container(
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.SizedBox(
//                     height: 10.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot.data!.data!.bookingId
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.garageDetails!.garageName
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.garageDetails!.email
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.garageDetails!.mobileNumber
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.garageDetails!.address
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.garageDetails!.city
//                       .toString()),
//                   pw.SizedBox(
//                     height: 10.h,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ));
//     pdf.addPage(pw.Page(
//       build: (context) {
//         return pw.Row(
//           children: [
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.SizedBox(
//                   height: 10.h,
//                 ),
//                 pw.Text('Car Model :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Year'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Mileage :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Cylinder :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//               ],
//             ),
//             pw.Container(
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.SizedBox(
//                     height: 10.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.carDetails!.model
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.carDetails!.modelYear
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.carDetails!.mileage
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.carDetails!.cylinder
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ));

//     pdf.addPage(pw.Page(
//       build: (context) {
//         return pw.Row(
//           children: [
//             pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.SizedBox(
//                   height: 10.h,
//                 ),
//                 pw.Text('Pickup ID :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('CX Name'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Email ID :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//                 pw.Text('Address :'),
//                 pw.SizedBox(
//                   height: 15.h,
//                 ),
//               ],
//             ),
//             pw.Container(
//               child: pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   pw.SizedBox(
//                     height: 10.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.pickupDetails!.id
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.pickupDetails!.name
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.pickupDetails!.email
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                   pw.Text(appoinmentdetailsSnapshot
//                       .data!.data!.pickupDetails!.address
//                       .toString()),
//                   pw.SizedBox(
//                     height: 15.h,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ));

//     final output = await getTemporaryDirectory();
//     // final file = File("${output.path}/example.pdf");
//     // final file = File('example.pdf');
//     Directory generalDownloadDir = Directory(
//         '/storage/emulated/0/Download'); //! THIS WORKS for android only !!!!!!
//     DateTime _now = DateTime.now();
//     final file = File(
//         "${generalDownloadDir.path}/imechano-${_now.day}${_now.month}${_now.year}-${_now.hour}_${_now.minute}_${_now.second}.pdf");
//     await file.writeAsBytes(await pdf.save());
//     print("File was downloaded to ${generalDownloadDir.path}");
//     Fluttertoast.showToast(
//         msg: ' File was downloaded to ${generalDownloadDir.path}',
//         gravity: ToastGravity.BOTTOM);
//   }
// }
