import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/Incoming_Booking_Details_Bloc.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_drawer_widget.dart';

import '../shared/widgets/form/custom_form.dart';

class CustomerEnquiry extends StatefulWidget {
  final String? id;
  const CustomerEnquiry({Key? key, this.id}) : super(key: key);

  @override
  _CustomerEnquiryState createState() => _CustomerEnquiryState();
}

class _CustomerEnquiryState extends State<CustomerEnquiry> {
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController enquiry = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    incomingBookingsDetailsBloc.onincomingdetailsSink(widget.id.toString());
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool value = false;
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     drawer: drawerpage(),
  //     backgroundColor: logoBlue,
  //     appBar: WidgetAppBar(
  //       title: 'Customer Enquiry',
  //       menuItem: 'assets/svg/Menu.svg',
  //       // action: 'assets/svg/add.svg',
  //       // action2: 'assets/svg/Alert.svg'
  //     ),
  //     body: ScreenUtilInit(
  //       designSize: Size(414, 896),
  //       builder: () => Container(
  //         margin: EdgeInsets.only(left: 10, right: 10),
  //         height: double.infinity,
  //         decoration: BoxDecoration(
  //             color: white,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //         child: Container(
  //           margin: EdgeInsets.only(left: 5, right: 5, top: 10),
  //           width: double.infinity,
  //           child: NotificationListener<OverscrollIndicatorNotification>(
  //               onNotification: (notification) {
  //                 notification.disallowGlow();
  //                 return true;
  //               },
  //               child: StreamBuilder<IncomingBookingsDetailsModel>(
  //                   stream: incomingBookingsDetailsBloc.incomingdetailsStream,
  //                   builder: (context,
  //                       AsyncSnapshot<IncomingBookingsDetailsModel>
  //                           incomingdetailsSnapshot) {
  //                     // if (!incomingdetailsSnapshot.hasData) {
  //                     //   return Center(child: CircularProgressIndicator());
  //                     // }
  //                     return incomingdetailsSnapshot.data == null
  //                         ? Text(
  //                             'No Data Found',
  //                             style: TextStyle(
  //                                 fontFamily: 'Poppins1', fontSize: 18.sp),
  //                           )
  //                         : SingleChildScrollView(
  //                             child: Column(
  //                               children: [
  //                                 Row(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.center,
  //                                     children: [
  //                                       Container(
  //                                         child: CircleAvatar(
  //                                           radius: 25,
  //                                           backgroundImage: AssetImage(
  //                                               "assets/Group 293.png"),
  //                                         ),
  //                                       ),
  //                                       SizedBox(
  //                                         width: 14.w,
  //                                       ),
  //                                       Text(
  //                                         "Customer Information",
  //                                         style: TextStyle(
  //                                             fontFamily: "Poppins1",
  //                                             fontSize: 13.sp),
  //                                       ),
  //                                       //SizedBox(width: 10),
  //                                       Spacer(),
  //                                       Padding(
  //                                         padding:
  //                                             const EdgeInsets.only(right: 8.0),
  //                                         child: Container(
  //                                           height: 40.h,
  //                                           child: OutlinedButton(
  //                                             style: OutlinedButton.styleFrom(
  //                                               side: BorderSide(
  //                                                 width: 1.0,
  //                                                 color: logoBlue,
  //                                                 style: BorderStyle.solid,
  //                                               ),
  //                                             ),
  //                                             onPressed: () {},
  //                                             child: Row(
  //                                               children: [
  //                                                 Text(
  //                                                   "Download",
  //                                                   style: TextStyle(
  //                                                       color: logoBlue,
  //                                                       fontSize: 10.sp,
  //                                                       fontFamily: "Poppins1"),
  //                                                 ),
  //                                                 SizedBox(width: 5.w),
  //                                                 SvgPicture.asset(
  //                                                     "assets/svg/Import.svg")
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ]),
  //                                 SizedBox(
  //                                   height: 10.h,
  //                                 ),
  //                                 Container(
  //                                   padding:
  //                                       EdgeInsets.only(left: 20, right: 20),
  //                                   decoration: BoxDecoration(
  //                                       color: Color(0xFFF5FAFF),
  //                                       border: Border(
  //                                           top: BorderSide(
  //                                               width: 1, color: grayE6E6E5),
  //                                           bottom: BorderSide(
  //                                               width: 1, color: grayE6E6E5))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           SizedBox(
  //                                             height: 10.h,
  //                                           ),
  //                                           textTitel('Booking ID :'),
  //                                           SizedBox(
  //                                             height: 15.h,
  //                                           ),
  //                                           textTitel('Garage Name :'),
  //                                           SizedBox(
  //                                             height: 15.h,
  //                                           ),
  //                                           textTitel('Brand :'),
  //                                           SizedBox(
  //                                             height: 15.h,
  //                                           ),
  //                                           textTitel('Email ID :'),
  //                                           SizedBox(
  //                                             height: 15.h,
  //                                           ),
  //                                           textTitel('Phone Number :'),
  //                                           SizedBox(
  //                                             height: 15.h,
  //                                           ),
  //                                           textTitel('Address :'),
  //                                           SizedBox(
  //                                             height: 15.h,
  //                                           ),
  //                                           textTitel('City/State :'),
  //                                           SizedBox(height: 10.h),
  //                                         ],
  //                                       ),
  //                                       Container(
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             SizedBox(
  //                                               height: 10.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!.data!.bookingId
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 15.h,
  //                                             ),
  //                                             textAns(''),
  //                                             SizedBox(
  //                                               height: 15.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .customerDetails!
  //                                                 .brand
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 15.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .customerDetails!
  //                                                 .email
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 15.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .customerDetails!
  //                                                 .mobileNumber
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 15.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .customerDetails!
  //                                                 .address
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 15.h,
  //                                             ),
  //                                             textAns(''),
  //                                             SizedBox(
  //                                               height: 10.h,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10.h,
  //                                 ),
  //                                 Row(children: [
  //                                   Container(
  //                                     child: CircleAvatar(
  //                                       radius: 25,
  //                                       backgroundImage:
  //                                           AssetImage("assets/Group 9382.png"),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 14.w,
  //                                   ),
  //                                   Text(
  //                                     "Car Information",
  //                                     style: TextStyle(
  //                                         fontFamily: "Poppins1",
  //                                         fontSize: 13.sp),
  //                                   ),
  //                                   Spacer(),
  //                                 ]),
  //                                 SizedBox(
  //                                   height: 10.h,
  //                                 ),
  //                                 Container(
  //                                   width: double.infinity,
  //                                   padding:
  //                                       EdgeInsets.only(left: 20, right: 20),
  //                                   decoration: BoxDecoration(
  //                                       color: Color(0xFFF5FAFF),
  //                                       border: Border(
  //                                           top: BorderSide(
  //                                               width: 1, color: grayE6E6E5),
  //                                           bottom: BorderSide(
  //                                               width: 1, color: grayE6E6E5))),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           SizedBox(
  //                                             height: 10.h,
  //                                           ),
  //                                           textTitel('Car Model :'),
  //                                           SizedBox(
  //                                             height: 13.h,
  //                                           ),
  //                                           textTitel('Make :'),
  //                                           SizedBox(
  //                                             height: 13.h,
  //                                           ),
  //                                           textTitel('Car Model :'),
  //                                           SizedBox(
  //                                             height: 13.h,
  //                                           ),
  //                                           textTitel('Year:'),
  //                                           SizedBox(
  //                                             height: 13.h,
  //                                           ),
  //                                           textTitel('Mileage:'),
  //                                           SizedBox(
  //                                             height: 13.h,
  //                                           ),
  //                                           textTitel('Service:'),
  //                                           SizedBox(height: 10.h),
  //                                         ],
  //                                       ),
  //                                       Padding(
  //                                         padding:
  //                                             const EdgeInsets.only(right: 40),
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             SizedBox(
  //                                               height: 10.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!.data!.carDetails!.model
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 13.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!.data!.carDetails!.make
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 13.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!.data!.carDetails!.model
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 13.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .carDetails!
  //                                                 .modelYear
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 13.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .carDetails!
  //                                                 .mileage
  //                                                 .toString()),
  //                                             SizedBox(
  //                                               height: 13.h,
  //                                             ),
  //                                             textAns(incomingdetailsSnapshot
  //                                                 .data!
  //                                                 .data!
  //                                                 .carDetails!
  //                                                 .cylinder
  //                                                 .toString()),
  //                                             SizedBox(height: 8.h)
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10.h,
  //                                 ),
  //                                 Row(children: [
  //                                   Container(
  //                                     child: CircleAvatar(
  //                                       radius: 25,
  //                                       backgroundImage:
  //                                           AssetImage("assets/Group 9382.png"),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 14.w,
  //                                   ),
  //                                   Text(
  //                                     "Type of Repair",
  //                                     style: TextStyle(
  //                                         fontFamily: "Poppins1",
  //                                         fontSize: 13.sp),
  //                                   ),
  //                                   Spacer(),
  //                                 ]),
  //                                 SizedBox(
  //                                   height: 10.h,
  //                                 ),
  //                                 Container(
  //                                   width: double.infinity,
  //                                   padding:
  //                                       EdgeInsets.only(left: 20, right: 20),
  //                                   decoration: BoxDecoration(
  //                                       color: Color(0xFFF5FAFF),
  //                                       border: Border(
  //                                           top: BorderSide(
  //                                               width: 1, color: grayE6E6E5),
  //                                           bottom: BorderSide(
  //                                               width: 1, color: grayE6E6E5))),
  //                                   child: Row(
  //                                     children: [
  //                                       Container(
  //                                         child: Column(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               SizedBox(
  //                                                 height: 10.h,
  //                                               ),
  //                                               Checkbox(
  //                                                   visualDensity:
  //                                                       VisualDensity(
  //                                                           horizontal: -4,
  //                                                           vertical: -4),
  //                                                   value: this.value,
  //                                                   onChanged: (bool? value) {
  //                                                     setState(() {
  //                                                       this.value = value!;
  //                                                     });
  //                                                   }),
  //                                               Checkbox(
  //                                                   visualDensity:
  //                                                       VisualDensity(
  //                                                           horizontal: -4,
  //                                                           vertical: -4),
  //                                                   value: this.value,
  //                                                   onChanged: (bool? value) {
  //                                                     setState(() {
  //                                                       this.value = value!;
  //                                                     });
  //                                                   }),
  //                                               Checkbox(
  //                                                   visualDensity:
  //                                                       VisualDensity(
  //                                                           horizontal: -4,
  //                                                           vertical: -4),
  //                                                   value: this.value,
  //                                                   onChanged: (bool? value) {
  //                                                     setState(() {
  //                                                       this.value = value!;
  //                                                     });
  //                                                   }),
  //                                               Checkbox(
  //                                                   visualDensity:
  //                                                       VisualDensity(
  //                                                           horizontal: -4,
  //                                                           vertical: -4),
  //                                                   value: this.value,
  //                                                   onChanged: (bool? value) {
  //                                                     setState(() {
  //                                                       this.value = value!;
  //                                                     });
  //                                                   }),
  //                                               Checkbox(
  //                                                   visualDensity:
  //                                                       VisualDensity(
  //                                                           horizontal: -4,
  //                                                           vertical: -4),
  //                                                   value: this.value,
  //                                                   onChanged: (bool? value) {
  //                                                     setState(() {
  //                                                       this.value = value!;
  //                                                     });
  //                                                   }),
  //                                               Checkbox(
  //                                                   visualDensity:
  //                                                       VisualDensity(
  //                                                           horizontal: -4,
  //                                                           vertical: -4),
  //                                                   value: this.value,
  //                                                   onChanged: (bool? value) {
  //                                                     setState(() {
  //                                                       this.value = value!;
  //                                                     });
  //                                                   }),
  //                                               SizedBox(height: 10.h),
  //                                             ]),
  //                                       ),
  //                                       SizedBox(width: 10.h),
  //                                       Container(
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             SizedBox(height: 10.h),
  //                                             textAns('Brake'),
  //                                             SizedBox(
  //                                               height: 18.h,
  //                                             ),
  //                                             textAns('Air Condition System'),
  //                                             SizedBox(
  //                                               height: 18.h,
  //                                             ),
  //                                             textAns(
  //                                                 'Steering Suspension Parts'),
  //                                             SizedBox(
  //                                               height: 18.h,
  //                                             ),
  //                                             textAns('Engine Oil'),
  //                                             SizedBox(
  //                                               height: 18.h,
  //                                             ),
  //                                             textAns('Bonnet Dent'),
  //                                             SizedBox(
  //                                               height: 18.h,
  //                                             ),
  //                                             textAns('Right Panal Bumper'),
  //                                             SizedBox(height: 10.h),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10.h,
  //                                 ),
  //                                 Row(children: [
  //                                   Container(
  //                                     child: CircleAvatar(
  //                                       radius: 25,
  //                                       backgroundImage:
  //                                           AssetImage("assets/Group 9431.png"),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 10.w,
  //                                   ),
  //                                   Text(
  //                                     "Comments",
  //                                     style: TextStyle(
  //                                         fontFamily: "Poppins1",
  //                                         fontSize: 13.sp),
  //                                   ),
  //                                 ]),
  //                                 Container(
  //                                   margin: EdgeInsets.all(10),
  //                                   decoration: BoxDecoration(
  //                                       color: cardgreycolor2,
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(10))),
  //                                   child: ListTile(
  //                                     subtitle: Container(
  //                                       margin: EdgeInsets.all(10),
  //                                       child: Text(
  //                                           "It does not look good as well as snatches the beauty of the car.You should get all your queries sorted out with your mechanic before handing your car him.",
  //                                           style: TextStyle(
  //                                               color: Colors.black,
  //                                               fontSize: 11.sp,
  //                                               fontFamily: "Poppins3")),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 20.h,
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                   })),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'Customer Enquiry',
        menuItem: 'assets/svg/Menu.svg',
        // action: 'assets/svg/add.svg',
        action2: 'assets/svg/ball.svg',
      ),
      key: _key,
      drawer: drawerpage(),
      backgroundColor: Color(0xff70bdf1),
      body: Form(
        key: _formKey,
        child: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
            child: Column(children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0))),
                    child: _body()),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              SingleChildScrollView(
                child: _scrollBarWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _scrollBarWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          nameForm(),
          SizedBox(height: 15.h),
          emailForm(),
          SizedBox(height: 15.h),
          mobileForm(),
          SizedBox(height: 15.h),
          enquiryForm(),
          SizedBox(height: 30.h),
          // gender(),
          // redio(),
          _save(),
        ],
      ),
    );
  }

  CustomForm nameForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter The Name';
        }
        return null;
      },
      controller: name,
      imagePath: 'assets/icons/auth/sign_up/name.png',
      hintText: 'Full Name',
    );
  }

  CustomForm emailForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter The Email';
        }
        return null;
      },
      controller: email,
      imagePath: 'assets/icons/auth/sign_up/email.png',
      hintText: 'Your Email',
    );
  }

  CustomForm mobileForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter The Mobile No';
        }
        return null;
      },
      controller: mobileno,
      imagePath: 'assets/icons/auth/sign_up/mobile-number.png',
      hintText: 'Your Mobile No',
    );
  }

  TextFormField enquiryForm() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter The Your Enquiry';
        }
        return null;
      },
      controller: enquiry,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        fillColor: grayE6E6E5,
        filled: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        hintText: "Your Enquiry",
        hintStyle: TextStyle(fontFamily: 'Poppins3'),
        prefixIconConstraints: BoxConstraints(minWidth: 40),
      ),
    );
    // return CustomForm(
    //   fillColor: grayE6E6E5,
    //   validationform: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Please enter Fil The Enquiry';
    //     }
    //     return null;
    //   },
    //   controller: enquiry,
    //   imagePath: 'assets/icons/auth/sign_up/mobile-number.png',
    //   hintText: 'Your Enquiry',
    //
    //   keyboardType: TextInputType.multiline,
    //   minLines: 1,//Normal textInputField will be displayed
    //   maxLines: 5,// when user presses enter it will adapt to it
    // );
  }

  Widget _save() {
    return Container(
      height: 58.h,
      width: 380.w,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(logoBlue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (_formKey.currentState!.validate()) {
            //   onUpdateProfileAPI();
            name.clear();
            email.clear();
            mobileno.clear();
            enquiry.clear();
            Fluttertoast.showToast(
                msg: "We have received your enquiry and will reply you asap.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.lightBlueAccent,
                textColor: Colors.white,
                fontSize: 15.0);
          }
        },
        child: Text(
          'Send Enquiry',
          style: TextStyle(fontFamily: "Poppins2", color: white, fontSize: 18),
        ),
      ),
    );
  }

  Widget textTitel(title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: "Poppins3",
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }

  Widget textAns(ans) {
    return Text(
      ans,
      style: TextStyle(
          fontFamily: "Poppins3",
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }
}
