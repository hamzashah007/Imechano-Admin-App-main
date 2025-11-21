import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bloc/garage_profile_bloc.dart';
import 'package:imechano_admin/ui/bloc/incoming_bookings_bloc.dart';
import 'package:imechano_admin/ui/bottombar/booking_list_show.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/constants.dart';
import 'package:imechano_admin/ui/model/accept_booking_model.dart';
import 'package:imechano_admin/ui/model/cancel_booking_model.dart';
import 'package:imechano_admin/ui/model/incoming_bookings_model.dart';
import 'package:imechano_admin/ui/model/reject_booking_model.dart';
import 'package:imechano_admin/ui/model/send_notification_customer.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/accept_dialog.dart';
import 'package:imechano_admin/ui/shared/widgets/confirmation_dialog.dart';
import 'package:intl/intl.dart';

class PickupSchedulePage extends StatefulWidget {
  final String? status;
  final String? delievery_charges;
  final Function? refreshData;
  final int initialIndex;
  PickupSchedulePage(
      {Key? key,
      this.status,
      this.refreshData,
      this.delievery_charges,
      this.initialIndex = 0})
      : super(key: key);

  @override
  _PickupSchedulePageState createState() => _PickupSchedulePageState();
}

class _PickupSchedulePageState extends State<PickupSchedulePage> {
  int selectedindex = 0;

  @override
  void initState() {
    selectFirstDate();
    selectedindex = widget.initialIndex;
    log('Selected index: $selectedindex');
    incomingBookingsBloc.onincomingBookSink(selectedindex.toString(),
        formatter.format(fromDate), formatter.format(toDate));
    super.initState();
  }

  TextEditingController charges = TextEditingController();

  final GlobalKey expansionTileKey = GlobalKey();

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate = DateTime(DateTime.now().year, 12, DateTime.now().day);

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

      setState(() {
        fromDate = picked;
      });
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
    }
    return _date;
  }

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
          title: 'Incoming Bookings',
          menuItem: 'assets/svg/Arrow_alt_left.svg',
          // action: 'assets/svg/add.svg',
          // action2: 'assets/svg/Alert.svg'
        ),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
              child: Container(
            child: Column(
              children: [
                Container(
                  height: 40.h,
                  margin: EdgeInsets.only(right: 5.w),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {
                            selectedindex = 0;

                            setState(() {
                              selectFirstDate();

                              incomingBookingsBloc.onincomingBookSink(
                                  '0',
                                  formatter.format(fromDate),
                                  formatter.format(toDate));
                            });
                          },
                          child: cardreview(
                              "New", selectedindex == 0 ? true : false)),
                      SizedBox(width: 8),
                      GestureDetector(
                          onTap: () {
                            selectedindex = 1;
                            setState(() {
                              selectFirstDate();

                              incomingBookingsBloc.onincomingBookSink(
                                  '1',
                                  formatter.format(fromDate),
                                  formatter.format(toDate));
                            });
                          },
                          child: cardreview(
                              "Pending", selectedindex == 1 ? true : false)),
                      SizedBox(width: 8),
                      GestureDetector(
                          onTap: () {
                            selectedindex = 2;
                            setState(() {
                              selectFirstDate();

                              incomingBookingsBloc.onincomingBookSink(
                                  '2',
                                  formatter.format(fromDate),
                                  formatter.format(toDate));
                            });
                          },
                          child: cardreview(
                              "Accepted", selectedindex == 2 ? true : false)),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            selectFirstDate();

                            selectedindex = 3;
                            setState(() {
                              incomingBookingsBloc.onincomingBookSink(
                                  '3',
                                  formatter.format(fromDate),
                                  formatter.format(toDate));
                            });
                          },
                          child: cardreview(
                              "Rejected", selectedindex == 3 ? true : false)),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                _customcontainer(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    toDate = DateTime(DateTime.now().year, 12, DateTime.now().day);

    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
    setState(() {});
  }

  Widget _customcontainer() {
    return Expanded(
      child: Container(
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
            _filterwidget(),
            Divider(color: black12color),
            Expanded(
              child: CardList(
                selectedIndex: selectedindex,
                fromDate: fromDate,
                toDate: toDate,
                formatter: formatter,
              ),
            ),
          ],
        ),
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
              fromDate = await selectDate(context, fromDate, 'toDate');
              print("New Date");
              print(fromDate);

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
              toDate = await selectToDate(context, toDate, 'fromDate');
              setState(() {});
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
                  height: 30.h,
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
                height: 30.h,
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
  CardList(
      {Key? key,
      this.refreshData,
      this.selectedIndex,
      this.fromDate,
      this.toDate,
      this.formatter,
      this.delievery_charges})
      : super(key: key);
  final Function? refreshData;
  final String? delievery_charges;
  int? selectedIndex;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateFormat? formatter;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final _repository = Repository();
  @override
  void initState() {
    super.initState();
    charges.clear();

    garageProfileAPIBloc.ongarageprofileblocSink();

    garageProfileAPIBloc.GarageProfileStream.listen((item) {
      setState(() {
        item.data!.forEach((element) {
          garages.add({element.garageId, element.garageName.toString()});
        });
        log(garages.toString());
      });
    });
  }

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController charges = TextEditingController();

  List<Set<String?>> garages = [];
  String? selectedValue1;

  @override
  Widget build(BuildContext context) {
    print("New Date From Build");
    print(widget.fromDate);

    return Scaffold(
      body: StreamBuilder<IncomingBookingsModel>(
          stream: incomingBookingsBloc.incomingStream,
          builder: (context,
              AsyncSnapshot<IncomingBookingsModel> incomingBookingsSnapshot) {
            if (!incomingBookingsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: buttonBlueBorder),
              );
            } else if (incomingBookingsSnapshot.data!.data == null) {
              return Center(
                child: CircularProgressIndicator(),
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

                          DateTime dateToCheck = DateTime.parse(
                              incomingBookingsSnapshot
                                  .data!.data![reverseIndex].bookingTime!
                                  .replaceAll('/', '-')
                                  .substring(0, 10));
                          String? subCategoryId = incomingBookingsSnapshot
                              .data!.data![reverseIndex].sub_category
                              .toString();

                          return ((dateToCheck.isAfter(widget.fromDate!) ||
                                      dateToCheck.isAtSameMomentAs(
                                          widget.fromDate!)) &&
                                  (dateToCheck.isBefore(widget.toDate!) ||
                                      dateToCheck
                                          .isAtSameMomentAs(widget.toDate!)))
                              ? Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
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
                                        Row(
                                          children: [
                                            SizedBox(width: 10.w),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  quickTiles.containsKey(
                                                          subCategoryId)
                                                      ? Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: quickTilesColors[
                                                                subCategoryId]!,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Text(
                                                            quickTiles[
                                                                subCategoryId]!,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Row(
                                                    children: [
                                                      carddivider(
                                                        "Customer Name",
                                                        incomingBookingsSnapshot
                                                            .data!
                                                            .data![reverseIndex]
                                                            .customerName!,
                                                      ),
                                                      SizedBox(
                                                        width: 38.w,
                                                      ),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          1.7),
                                                              child: Text(
                                                                "Booking Time",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontFamily:
                                                                      'Poppins3',
                                                                  fontSize:
                                                                      11.sp,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_today,
                                                                  size: 20.w,
                                                                  color:
                                                                      logoBlue,
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Text(
                                                                  incomingBookingsSnapshot
                                                                      .data!
                                                                      .data![
                                                                          reverseIndex]
                                                                      .bookingTime!,
                                                                  // .substring(
                                                                  //     0,
                                                                  //     10),
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Poppins3',
                                                                    fontSize:
                                                                        9.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      carddivider(
                                                          "Booking Id",
                                                          incomingBookingsSnapshot
                                                              .data!
                                                              .data![
                                                                  reverseIndex]
                                                              .bookingId!),
                                                      SizedBox(width: 87.7.w),
                                                      carddivider(
                                                          "Garage Name",
                                                          incomingBookingsSnapshot
                                                              .data!
                                                              .data![
                                                                  reverseIndex]
                                                              .garageName!),
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
                                                                      BookingListShow(bookingid: incomingBookingsSnapshot.data!.data![reverseIndex].bookingId!)));
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.034,
                                                          width: 90.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: logoBlue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'View Details',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins3',
                                                                  fontSize:
                                                                      11.sp,
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 1.7),
                                                            child: Text(
                                                              "Appointment Time",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                fontFamily:
                                                                    'Poppins3',
                                                                fontSize: 11.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_today,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Poppins3',
                                                                  fontSize:
                                                                      9.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  widget.selectedIndex == 0
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  bottom: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (charges
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    charges.text =
                                                                        '';
                                                                  }
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AcceptDialog(
                                                                        customerId: incomingBookingsSnapshot
                                                                            .data!
                                                                            .data![reverseIndex]
                                                                            .customerId
                                                                            .toString(),
                                                                        message:
                                                                            'accept this booking?',
                                                                        chargesController:
                                                                            charges,
                                                                        garages:
                                                                            garages,
                                                                        selectedValue1:
                                                                            selectedValue1,
                                                                        formatter:
                                                                            widget.formatter!,
                                                                        fromDate:
                                                                            widget.fromDate,
                                                                        toDate:
                                                                            widget.toDate,
                                                                        bookingID: incomingBookingsSnapshot
                                                                            .data!
                                                                            .data![reverseIndex]
                                                                            .bookingId!,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.034,
                                                                  width: 90.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        logoBlue,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Accept',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins3',
                                                                          fontSize: 11
                                                                              .sp,
                                                                          color:
                                                                              white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 40.w,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return ConfirmationDialog(
                                                                            message:
                                                                                'reject this boooking?',
                                                                            onYesPressed:
                                                                                () async {
                                                                              await rejectbookingApiCall(incomingBookingsSnapshot.data!.data![reverseIndex].bookingId!);
                                                                              await cancelBooking(incomingBookingsSnapshot.data!.data![reverseIndex].bookingId!);
                                                                              Navigator.pop(context);
                                                                              Get.offAll(() => PickupSchedulePage(initialIndex: 3));
                                                                            });
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.034,
                                                                  width: 90.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Reject',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Poppins3',
                                                                          fontSize: 11
                                                                              .sp,
                                                                          color:
                                                                              white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  );
          }),
    );
  }

  Widget carddivider(String title, String Subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
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

  Future rejectbookingApiCall(String bookingId) async {
    Loader().showLoader(context);
    final RejectBookingModel isrejectbooking =
        await _repository.onRejectBookingAPI(bookingId);
    if (isrejectbooking.code != '0') {
      Loader().hideLoader(context);
      snackBar(isrejectbooking.message ?? 'Reject Booking');
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      incomingBookingsBloc.onincomingBookSink(
          '0',
          widget.formatter!.format(widget.fromDate!),
          widget.formatter!.format(widget.toDate!));
      // onSendNotificationAPIreject();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isrejectbooking.message != null ? isrejectbooking.message! : '');
    }
  }

  Future cancelBooking(String? bookingId) async {
    // show loader
    Loader().showLoader(context);
    final CancelBookingModel isCancelBooking =
        await _repository.onCancelBooking(bookingId!);

    if (isCancelBooking.code == '1') {
      Loader().hideLoader(context);
      snackBar(isCancelBooking.message ?? 'Booking Cancel');
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isCancelBooking.message ?? 'Something went to wrong');
    }
  }

  dynamic acceptbookingApiCall(
      String bookingId, String? delieveryCharges, String garageId) async {
    Loader().showLoader(context);
    final AcceptBookingModel isacceptbooking =
        await _repository.onAcceptBookingAPI(bookingId, charges.text, garageId);
    if (isacceptbooking.code != '0') {
      Loader().hideLoader(context);
      charges.clear();
      snackBar(isacceptbooking.message ?? 'Accept Booking');
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      incomingBookingsBloc.onincomingBookSink(
          '0',
          widget.formatter!.format(widget.fromDate!),
          widget.formatter!.format(widget.toDate!));
      // onSendNotificationAPI();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isacceptbooking.message != null ? isacceptbooking.message! : '');
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
