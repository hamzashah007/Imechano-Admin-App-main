// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/customer_details_bloc.dart';
import 'package:imechano_admin/ui/model/customer_details_model.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class CXData extends StatefulWidget {
  const CXData({Key? key, this.customer_id}) : super(key: key);
  final String? customer_id;
  @override
  _CXDataState createState() => _CXDataState();
}

class _CXDataState extends State<CXData> {
  @override
  void initState() {
    super.initState();
    // customerdataaPIbloc.oncustomerdatablocSink();
    customerDeatilsAPIBloc
        .oncustomerdetailsblocSink(widget.customer_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    print("MT SDAS");
    print(widget.customer_id);
    return Scaffold(
      backgroundColor: logoBlue,
      appBar: WidgetAppBar(
        title: 'Cx Data',
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
              child: StreamBuilder<CustomerDetailsModel>(
                  stream: customerDeatilsAPIBloc.CustomerDetailsStream,
                  builder: (context,
                      AsyncSnapshot<CustomerDetailsModel>
                          customerdetailsSnapshot) {
                    if (!customerdetailsSnapshot.hasData) {
                      return Center(
                          child: customerdetailsSnapshot.data == null
                              ? CircularProgressIndicator()
                              : Text(
                                  'No Data Found',
                                  style: TextStyle(
                                      fontFamily: 'Poppins1', fontSize: 18.sp),
                                ));
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage("assets/Group 293.png"),
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                Text(
                                  "Customer Details",
                                  style: TextStyle(
                                      fontFamily: "Poppins1", fontSize: 13.sp),
                                ),
                                //SizedBox(width: 10),
                                Spacer(),
                              ]),
                          SizedBox(height: 11.h),
                          //_customerdetail(),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5FAFF),
                                border: Border(
                                    top:
                                        BorderSide(width: 1, color: grayE6E6E5),
                                    bottom: BorderSide(
                                        width: 1, color: grayE6E6E5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    textTitel('Booking ID :'),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textTitel('CX Name :'),
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
                                    textTitel('Garage Profile :'),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textTitel('Address :'),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textTitel('City/State :'),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                                SizedBox(width: 15.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    textAns(customerdetailsSnapshot
                                        .data!.data!.bookingId
                                        .toString()),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textAns(customerdetailsSnapshot
                                        .data!.data!.customerDetails!.name
                                        .toString()),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textAns(customerdetailsSnapshot.data!.data!
                                        .customerDetails!.mobileNumber
                                        .toString()),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    textAns(customerdetailsSnapshot
                                        .data!.data!.customerDetails!.email
                                        .toString()),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    // customerSnapshot.data!.data![0]
                                    //             .garageProfile !=
                                    //         ''
                                    //     ? textAns(customerSnapshot
                                    //         .data!.data![0].garageProfile)
                                    //     : textAns('-'),

                                    textAns('-'),
                                    SizedBox(height: 15.h),
                                    textAns('-'),
                                    SizedBox(height: 15.h),
                                    textAns('-'),
                                    SizedBox(height: 10.h)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(children: [
                            Container(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/Group 9382.png"),
                              ),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text(
                              "Car Information",
                              style: TextStyle(
                                  fontFamily: "Poppins1", fontSize: 13.sp),
                            ),
                            Spacer(),
                          ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          // _carinformation(),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5FAFF),
                                border: Border(
                                    top:
                                        BorderSide(width: 1, color: grayE6E6E5),
                                    bottom: BorderSide(
                                        width: 1, color: grayE6E6E5))),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    textTitel('Date/Time :'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    // textTitel('Make :'),
                                    // SizedBox(
                                    //   height: 13.h,
                                    // ),
                                    textTitel('Car Model :'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Year :'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Mileage :'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Service :'),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                                SizedBox(width: 15.h),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 40,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      textAns(customerdetailsSnapshot
                                          .data!.data!.timeDate),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      // textAns(customerdetailsSnapshot
                                      //     .data!.data!),
                                      // SizedBox(
                                      //   height: 13.h,
                                      // ),
                                      textAns(customerdetailsSnapshot
                                          .data!.data!.carDetails!.model),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(customerdetailsSnapshot
                                          .data!.data!.carDetails!.modelYear),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(customerdetailsSnapshot
                                          .data!.data!.carDetails!.mileage),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(''),
                                      SizedBox(height: 8.h)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(children: [
                            Container(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage("assets/Group 9382.png"),
                              ),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Text(
                              "Parts Information",
                              style: TextStyle(
                                  fontFamily: "Poppins1", fontSize: 13.sp),
                            ),
                            Spacer(),
                          ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          // _partsinformation(),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5FAFF),
                                border: Border(
                                    top:
                                        BorderSide(width: 1, color: grayE6E6E5),
                                    bottom: BorderSide(
                                        width: 1, color: grayE6E6E5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    textTitel('Date/Time:'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Make'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Car Model:'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Year:'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Mileage:'),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    textTitel('Service:'),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      textAns(''),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(''),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(''),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(''),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(''),
                                      SizedBox(
                                        height: 13.h,
                                      ),
                                      textAns(''),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
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
