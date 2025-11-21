import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bloc/incoming_bookings_bloc.dart';
import 'package:imechano_admin/ui/bottombar/booking_list_show.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/model/incoming_bookings_model.dart';
import 'package:imechano_admin/ui/model/reject_booking_model.dart';
import 'package:imechano_admin/ui/model/send_notification_customer.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:intl/intl.dart';

class DeadBookings extends StatefulWidget {
  const DeadBookings(
      {Key? key, this.status, this.refreshData, this.delievery_charges})
      : super(key: key);
  final String? status;
  final String? delievery_charges;
  final Function? refreshData;
  @override
  _DeadBookingsState createState() => _DeadBookingsState();
}

class _DeadBookingsState extends State<DeadBookings> {
  @override
  void initState() {
    selectFirstDate();
    incomingBookingsBloc.onincomingBookSink(
        '1',
        formatter.format(fromDate.add(Duration(days: 30))),
        formatter.format(toDate));
    super.initState();
  }

  TextEditingController charges = TextEditingController();
  List dataList = [
    CardList(),
    CardList1(),
    CardList2(),
    CardList3(),
  ];

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  String fullName = '';

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate = DateTime(
      DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  String search = "";
  bool showFilter = false;

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: toDate,
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '1', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: fromDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '1', formatter.format(fromDate), formatter.format(toDate));
    }
    return _date;
  }

  int selectedindex = 1;
  final _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!Navigator.of(context).canPop()) {
          // If there's no screen in the stack, navigate to home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBarPage()),
          );
          return false; // Return false to prevent the app from closing
        } else {
          return true; // Return true to allow the app to close
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff70bdf1),
        appBar: WidgetAppBar(
          title: 'Dead Bookings',
          menuItem: 'assets/svg/Arrow_alt_left.svg',
          // action: 'assets/svg/add.svg',
          // action2: 'assets/svg/Alert.svg'
        ),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(child: _customcontainer()),
        ),
      ),
    );
  }

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  Widget _customcontainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          _searchfilterwidget(),
          if (showFilter) ...[
            // These children are only visible if condition is true
            SizedBox(height: 15.h),
            _filterwidget(),
          ],
          // _filterwidget(),
          Divider(color: black12color),
          Expanded(
            child: CardList(
                // selectedIndex: selectedindex,
                // fromDate: fromDate,
                // toDate: toDate,
                // formatter: formatter,
                ),
          ),
        ],
      ),
    );
  }

  Widget _filterwidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              Loader().showLoader(context);
              fromDate = await selectDate(context, fromDate, 'toDate');
              Loader().hideLoader(context);
              setState(() {});
            },
            child: Column(
              children: [
                Text(
                  "Start Date",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 96.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: black12color),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${formatter.format(fromDate)}",
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: 'Poppins3'),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              log('Before to date');
              toDate = await selectToDate(context, toDate, 'fromDate');
              log('After to date');
            },
            child: Column(
              children: [
                Text(
                  "End Date",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 96.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: black12color),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${formatter.format(toDate)}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: 'Poppins3',
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print("I m pressed");
              selectFirstDate();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
              child: Container(
                width: 80.w,
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: black12color),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: 'Poppins3',
                      ),
                    ),
                    Icon(
                      Icons.filter_list_alt,
                      size: 16.h,
                      color: logoBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                    borderRadius: BorderRadius.circular(20),
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
          GestureDetector(
            onTap: () {
              // _showBottomSheet(context);
              setState(() {
                showFilter = !showFilter;
              });
            },
            child: card(
                "Filter",
                Icon(
                  Icons.filter_list_alt,
                  size: 17,
                  color: logoBlue,
                )),
          ),
        ],
      ),
    );
  }

  Widget card(String title, Icon icon123) {
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black54, width: 1)),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 3),
      width: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Text(
            title,
            style: TextStyle(fontFamily: "Poppins1", fontSize: 13.sp),
          ),
          icon123 = icon123,
        ],
      ),
    );
  }

  Widget cardreview(String title, bool isselected) {
    return new Container(
      decoration: BoxDecoration(
        border: Border.all(color: white),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: isselected ? Colors.white : Color(0xff70BDF1),
      ),
      alignment: Alignment.center,
      width: 90.w,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Poppins1",
          color: !isselected ? Colors.white : Color(0xff70BDF1),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  const CardList({Key? key, this.refreshData, this.delievery_charges})
      : super(key: key);
  final Function? refreshData;
  final String? delievery_charges;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final _repository = Repository();
  @override
  void initState() {
    charges.clear();
    selectFirstDate();

    incomingBookingsBloc.onincomingBookSink(
        '0', formatter.format(fromDate), formatter.format(toDate));
    super.initState();
  }

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController charges = TextEditingController();
  String fullName = '';

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '0', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '0', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<IncomingBookingsModel>(
          stream: incomingBookingsBloc.incomingStream,
          builder: (context,
              AsyncSnapshot<IncomingBookingsModel> incomingBookingsSnapshot) {
            if (!incomingBookingsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: buttonBlueBorder),
              );
            }
            return incomingBookingsSnapshot.data!.data!.length == 0
                ? Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                    ),
                  )
                : Container(
                    height: double.infinity,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: incomingBookingsSnapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          int reverseIndex =
                              incomingBookingsSnapshot.data!.data!.length -
                                  1 -
                                  index;

                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              decoration: BoxDecoration(
                                border: Border.all(color: grayE6E6E5),
                                boxShadow: [
                                  BoxShadow(
                                    color: grayE6E6E5,
                                    blurRadius: 20.0,
                                  ),
                                ],
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 20.w,
                                          color: logoBlue,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          incomingBookingsSnapshot
                                              .data!
                                              .data![reverseIndex]
                                              .appointmentTime!,
                                          style: TextStyle(
                                            fontFamily: 'Poppins3',
                                            fontSize: 9.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10.w),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: incomingBookingsSnapshot
                                                    .data!
                                                    .data![reverseIndex]
                                                    .carImage ==
                                                ''
                                            ? Image.asset(
                                                'assets/Group 9389.png',
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Image.network(
                                                incomingBookingsSnapshot
                                                    .data!
                                                    .data![reverseIndex]
                                                    .carImage!,
                                                fit: BoxFit.fitWidth,
                                              ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, bottom: 10.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            carddivider(
                                              "Customer Name",
                                              incomingBookingsSnapshot
                                                  .data!
                                                  .data![reverseIndex]
                                                  .customerName!,
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                carddivider(
                                                    "Order Id",
                                                    incomingBookingsSnapshot
                                                        .data!
                                                        .data![reverseIndex]
                                                        .bookingId!),
                                                SizedBox(width: 35.w),
                                                Container(
                                                    height: 30.h,
                                                    child: VerticalDivider(
                                                      color: grayE6E6E5,
                                                      thickness: 1,
                                                    )),
                                                SizedBox(width: 35.w),
                                                carddivider("Grg Name",
                                                    "Imechano Place"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    //TODO DATA BOOKING
                                                                    BookingListShow(
                                                                        bookingid: incomingBookingsSnapshot
                                                                            .data!
                                                                            .data![reverseIndex]
                                                                            .id
                                                                            .toString())));
                                                  },
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.034,
                                                    width: 90.w,
                                                    decoration: BoxDecoration(
                                                      color: logoBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'View Details',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins3',
                                                            fontSize: 11.sp,
                                                            color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Appointment time",
                                                      style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontFamily: 'Poppins3',
                                                        fontSize: 11.sp,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.calendar_today,
                                                          size: 20.w,
                                                          color: logoBlue,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          incomingBookingsSnapshot
                                                              .data!
                                                              .data![
                                                                  reverseIndex]
                                                              .appointmentTime!,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins3',
                                                            fontSize: 9.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6.h),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 10.h, top: 5.h),
                                              height: 60.h,
                                              width: 150.w,
                                              decoration: BoxDecoration(
                                                color: cardgreycolor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: TextField(
                                                controller: charges,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                      ),
                                                    ),
                                                    hintText: 'Charges',
                                                    hintStyle: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontFamily: 'Poppins3'),
                                                    fillColor: cardgreycolor,
                                                    filled: true),
                                              ),
                                            ),
                                            // Container(
                                            //   height: 20,
                                            //   width: 30,
                                            //   color: Colors.black,
                                            // ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.034,
                                                    width: 90.w,
                                                    decoration: BoxDecoration(
                                                      color: logoBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Accept',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins3',
                                                            fontSize: 11.sp,
                                                            color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40.w,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      rejectbookingApiCall(
                                                          incomingBookingsSnapshot
                                                              .data!
                                                              .data![
                                                                  reverseIndex]
                                                              .bookingId!);
                                                      widget.refreshData!(true);
                                                    });
                                                  },
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.034,
                                                    width: 90.w,
                                                    decoration: BoxDecoration(
                                                      color: logoBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins3',
                                                            fontSize: 11.sp,
                                                            color: white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }),
    );
  }

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  Widget carddivider(String title, String Subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
        Text(
          Subtitle,
          style: TextStyle(
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  rejectbookingApiCall(String bookingId) async {
    Loader().showLoader(context);
    final RejectBookingModel isrejectbooking =
        await _repository.onRejectBookingAPI(bookingId);
    if (isrejectbooking.code != '0') {
      Loader().hideLoader(context);
      snackBar(isrejectbooking.message ?? 'Reject Booking');
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      incomingBookingsBloc.onincomingBookSink(
          '0', formatter.format(fromDate), formatter.format(toDate));
      // onSendNotificationAPIreject();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isrejectbooking.message != null ? isrejectbooking.message! : '');
    }
  }

  dynamic onSendNotificationAPIreject(String customerId) async {
    final SendNotificationCustomerModel isCustomer = await _repository
        .onSendNotificationAPI(customerId, 'Reject', 'message1');

    if (isCustomer.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isCustomer.message != null ? isCustomer.message! : '');
    }
  }

  dynamic onSendNotificationAPI(String customerId) async {
    final SendNotificationCustomerModel isCustomer = await _repository
        .onSendNotificationAPI(customerId, 'Accepte', 'message1');

    if (isCustomer.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isCustomer.message != null ? isCustomer.message! : '');
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CardList1 extends StatefulWidget {
  const CardList1({Key? key, this.refreshData, this.delievery_charges})
      : super(key: key);
  final Function? refreshData;
  final String? delievery_charges;

  @override
  State<CardList1> createState() => _CardList1State();
}

class _CardList1State extends State<CardList1> {
  final _repository = Repository();
  @override
  void initState() {
    selectFirstDate();

    incomingBookingsBloc.onincomingBookSink(
        '1',
        formatter.format(fromDate.add(Duration(days: 30))),
        formatter.format(toDate));
    super.initState();
  }

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  String fullName = '';

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;
      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '1', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '1', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<IncomingBookingsModel>(
          stream: incomingBookingsBloc.incomingStream,
          builder: (context,
              AsyncSnapshot<IncomingBookingsModel> incomingBookingsSnapshot) {
            if (!incomingBookingsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return incomingBookingsSnapshot.data!.data!.length == 0
                ? Text(
                    'No Data Found',
                    style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                  )
                : Container(
                    height: double.infinity,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: incomingBookingsSnapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          int reverseIndex =
                              incomingBookingsSnapshot.data!.data!.length -
                                  1 -
                                  index;

                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(
                                border: Border.all(color: grayE6E6E5),
                                boxShadow: [
                                  BoxShadow(
                                    color: grayE6E6E5,
                                    blurRadius: 20.0,
                                  ),
                                ],
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: incomingBookingsSnapshot.data!
                                                .data![reverseIndex].carImage ==
                                            ''
                                        ? Image.asset(
                                            'assets/Group 9389.png',
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.network(
                                            incomingBookingsSnapshot.data!
                                                .data![reverseIndex].carImage!,
                                            fit: BoxFit.fitWidth,
                                          ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.w, bottom: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incomingBookingsSnapshot
                                              .data!
                                              .data![reverseIndex]
                                              .customerName!,
                                          style: TextStyle(
                                              fontFamily: 'Poppins3',
                                              fontSize: 13.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            carddivider(
                                                "Order Id",
                                                incomingBookingsSnapshot
                                                    .data!
                                                    .data![reverseIndex]
                                                    .bookingId!),
                                            SizedBox(width: 35.w),
                                            Container(
                                                height: 30.h,
                                                child: VerticalDivider(
                                                  color: grayE6E6E5,
                                                  thickness: 1,
                                                )),
                                            SizedBox(width: 35.w),
                                            carddivider(
                                                "Grg Name", "Imechano Place"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            //TODO DATA BOOKING
                                                            BookingListShow(
                                                                bookingid: incomingBookingsSnapshot
                                                                    .data!
                                                                    .data![
                                                                        reverseIndex]
                                                                    .id
                                                                    .toString())));
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.034,
                                                width: 90.w,
                                                decoration: BoxDecoration(
                                                  color: logoBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'View Details',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins3',
                                                        fontSize: 11.sp,
                                                        color: white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 20.w,
                                                  color: logoBlue,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  incomingBookingsSnapshot
                                                      .data!
                                                      .data![reverseIndex]
                                                      .appointmentTime!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins3',
                                                    fontSize: 9.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }),
    );
  }

  void selectFirstDate() async {
    fromDate = DateTime(
        DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  Widget carddivider(String title, String Subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
        Text(
          Subtitle,
          style: TextStyle(
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  rejectbookingApiCall(String bookingId) async {
    Loader().showLoader(context);
    final RejectBookingModel isrejectbooking =
        await _repository.onRejectBookingAPI(bookingId);
    if (isrejectbooking.code != '0') {
      Loader().hideLoader(context);
      snackBar(isrejectbooking.message ?? 'Reject Booking');
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      incomingBookingsBloc.onincomingBookSink(
          '1', formatter.format(fromDate), formatter.format(toDate));
      // onSendNotificationAPIreject();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isrejectbooking.message != null ? isrejectbooking.message! : '');
    }
  }

  // dynamic onSendNotificationAPIreject() async {
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Reject', 'message1');
  //
  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }
  //
  // dynamic onSendNotificationAPI() async {
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Accepte', 'message1');
  //
  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CardList2 extends StatefulWidget {
  const CardList2({Key? key, this.refreshData, this.delievery_charges})
      : super(key: key);
  final Function? refreshData;
  final String? delievery_charges;

  @override
  State<CardList2> createState() => _CardList2State();
}

class _CardList2State extends State<CardList2> {
  final _repository = Repository();
  @override
  void initState() {
    selectFirstDate();

    incomingBookingsBloc.onincomingBookSink(
        '2', formatter.format(fromDate), formatter.format(toDate));
    super.initState();
  }

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  String fullName = '';

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '2', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '2', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<IncomingBookingsModel>(
          stream: incomingBookingsBloc.incomingStream,
          builder: (context,
              AsyncSnapshot<IncomingBookingsModel> incomingBookingsSnapshot) {
            if (!incomingBookingsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return incomingBookingsSnapshot.data!.data!.length == 0
                ? Text(
                    'No Data Found',
                    style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                  )
                : Container(
                    height: double.infinity,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: incomingBookingsSnapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          int reverseIndex =
                              incomingBookingsSnapshot.data!.data!.length -
                                  1 -
                                  index;
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(
                                border: Border.all(color: grayE6E6E5),
                                boxShadow: [
                                  BoxShadow(
                                    color: grayE6E6E5,
                                    blurRadius: 20.0,
                                  ),
                                ],
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: incomingBookingsSnapshot.data!
                                                .data![reverseIndex].carImage ==
                                            ''
                                        ? Image.asset(
                                            'assets/Group 9389.png',
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.network(
                                            incomingBookingsSnapshot.data!
                                                .data![reverseIndex].carImage!,
                                            fit: BoxFit.fitWidth,
                                          ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.w, bottom: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incomingBookingsSnapshot
                                              .data!
                                              .data![reverseIndex]
                                              .customerName!,
                                          style: TextStyle(
                                              fontFamily: 'Poppins3',
                                              fontSize: 13.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            carddivider(
                                                "Order Id",
                                                incomingBookingsSnapshot
                                                    .data!
                                                    .data![reverseIndex]
                                                    .bookingId!),
                                            SizedBox(width: 35.w),
                                            Container(
                                                height: 30.h,
                                                child: VerticalDivider(
                                                  color: grayE6E6E5,
                                                  thickness: 1,
                                                )),
                                            SizedBox(width: 35.w),
                                            carddivider(
                                                "Grg Name", "Imechano Place"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            //TODO DATA BOOKING
                                                            BookingListShow(
                                                                bookingid: incomingBookingsSnapshot
                                                                    .data!
                                                                    .data![
                                                                        reverseIndex]
                                                                    .id
                                                                    .toString())));
                                                widget.refreshData!(true);
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.034,
                                                width: 90.w,
                                                decoration: BoxDecoration(
                                                  color: logoBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'View Details',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins3',
                                                        fontSize: 11.sp,
                                                        color: white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 20.w,
                                                  color: logoBlue,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  incomingBookingsSnapshot
                                                      .data!
                                                      .data![reverseIndex]
                                                      .appointmentTime!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins3',
                                                    fontSize: 9.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }),
    );
  }

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  Widget carddivider(String title, String Subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
        Text(
          Subtitle,
          style: TextStyle(
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  rejectbookingApiCall(String bookingId) async {
    Loader().showLoader(context);
    final RejectBookingModel isrejectbooking =
        await _repository.onRejectBookingAPI(bookingId);
    if (isrejectbooking.code != '0') {
      Loader().hideLoader(context);
      snackBar(isrejectbooking.message ?? 'Reject Booking');
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      incomingBookingsBloc.onincomingBookSink(
          '2', formatter.format(fromDate), formatter.format(toDate));
      // onSendNotificationAPIreject();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isrejectbooking.message != null ? isrejectbooking.message! : '');
    }
  }

  // dynamic onSendNotificationAPIreject() async {
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Reject', 'message1');
  //
  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }
  //
  // dynamic onSendNotificationAPI() async {
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Accepte', 'message1');
  //
  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CardList3 extends StatefulWidget {
  const CardList3({Key? key, this.refreshData, this.delievery_charges})
      : super(key: key);
  final Function? refreshData;
  final String? delievery_charges;

  @override
  State<CardList3> createState() => _CardList3State();
}

class _CardList3State extends State<CardList3> {
  final _repository = Repository();
  @override
  void initState() {
    selectFirstDate();

    incomingBookingsBloc.onincomingBookSink(
        '3', formatter.format(fromDate), formatter.format(toDate));
    super.initState();
  }

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  String fullName = '';

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '3', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      setState(() {});
      incomingBookingsBloc.onincomingBookSink(
          '3', formatter.format(fromDate), formatter.format(toDate));
      // if (type == 'fromDate') {
      //   // statementInBloc.statementInsink(fromdate, todate);
      // }
    }
    return _date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<IncomingBookingsModel>(
          stream: incomingBookingsBloc.incomingStream,
          builder: (context,
              AsyncSnapshot<IncomingBookingsModel> incomingBookingsSnapshot) {
            if (!incomingBookingsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return incomingBookingsSnapshot.data!.data!.length == 0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        'No Data Found',
                        style:
                            TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                      ),
                    ),
                  )
                : Container(
                    height: double.infinity,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                        // reverse: true,
                        itemCount: incomingBookingsSnapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          int reverseIndex =
                              incomingBookingsSnapshot.data!.data!.length -
                                  1 -
                                  index;
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(
                                border: Border.all(color: grayE6E6E5),
                                boxShadow: [
                                  BoxShadow(
                                    color: grayE6E6E5,
                                    blurRadius: 20.0,
                                  ),
                                ],
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: incomingBookingsSnapshot.data!
                                                .data![reverseIndex].carImage ==
                                            ''
                                        ? Image.asset(
                                            'assets/Group 9389.png',
                                            fit: BoxFit.fitWidth,
                                          )
                                        : Image.network(
                                            incomingBookingsSnapshot.data!
                                                .data![reverseIndex].carImage!,
                                            fit: BoxFit.fitWidth,
                                          ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.w, bottom: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incomingBookingsSnapshot
                                              .data!
                                              .data![reverseIndex]
                                              .customerName!,
                                          style: TextStyle(
                                              fontFamily: 'Poppins3',
                                              fontSize: 13.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            carddivider(
                                                "Order Id",
                                                incomingBookingsSnapshot
                                                    .data!
                                                    .data![reverseIndex]
                                                    .bookingId!),
                                            SizedBox(width: 35.w),
                                            Container(
                                                height: 30.h,
                                                child: VerticalDivider(
                                                  color: grayE6E6E5,
                                                  thickness: 1,
                                                )),
                                            SizedBox(width: 35.w),
                                            carddivider(
                                                "Grg Name", "Imechano Place"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            //TODO DATA BOOKING
                                                            BookingListShow(
                                                                bookingid: incomingBookingsSnapshot
                                                                    .data!
                                                                    .data![
                                                                        reverseIndex]
                                                                    .id
                                                                    .toString())));
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.034,
                                                width: 90.w,
                                                decoration: BoxDecoration(
                                                  color: logoBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'View Details',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins3',
                                                        fontSize: 11.sp,
                                                        color: white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40.w,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 20.w,
                                                  color: logoBlue,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  incomingBookingsSnapshot
                                                      .data!
                                                      .data![reverseIndex]
                                                      .appointmentTime!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins3',
                                                    fontSize: 9.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }),
    );
  }

  void selectFirstDate() async {
    fromDate = DateTime(
        DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  Widget carddivider(String title, String Subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
        Text(
          Subtitle,
          style: TextStyle(
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  rejectbookingApiCall(String bookingId) async {
    Loader().showLoader(context);
    final RejectBookingModel isrejectbooking =
        await _repository.onRejectBookingAPI(bookingId);
    if (isrejectbooking.code != '0') {
      Loader().hideLoader(context);
      snackBar(isrejectbooking.message ?? 'Reject Booking');
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      incomingBookingsBloc.onincomingBookSink(
          '3', formatter.format(fromDate), formatter.format(toDate));
      // onSendNotificationAPIreject();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isrejectbooking.message != null ? isrejectbooking.message! : '');
    }
  }

  // dynamic onSendNotificationAPIreject() async {
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Reject', 'message1');
  //
  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }
  //
  // dynamic onSendNotificationAPI() async {
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Accepte', 'message1');
  //
  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
