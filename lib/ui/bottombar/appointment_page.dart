// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bloc/appoiement_list_bloc.dart';
import 'package:imechano_admin/ui/bottombar/booking_list_show.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/bottombar/create_job_card.dart';
import 'package:imechano_admin/ui/bottombar/pickup_and%20_fix_page.dart';
import 'package:imechano_admin/ui/model/appoiement_list_model.dart';
import 'package:imechano_admin/ui/model/send_notification_customer.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/payment_method_dialog.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage(
      {Key? key,
      this.appoiement_id,
      this.job_number,
      this.garage_id,
      this.booking_id})
      : super(key: key);
  final String? appoiement_id;
  final String? job_number;
  final String? garage_id;
  final String? booking_id;
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  // List<Set<String?>> garages = [];
  @override
  void initState() {
    super.initState();
    selectFirstDate();
    appointmentListBloc.onAppointmentListSink(
        formatter.format(fromDate), formatter.format(toDate));

    // garageProfileAPIBloc.ongarageprofileblocSink();

    // garageProfileAPIBloc.GarageProfileStream.listen((item) {
    //   item.data!.forEach((element) {
    //     garages.add({element.garageId, element.garageName.toString()});
    //   });
    //   setState(() {
    //     log(garages.toString());
    //   });
    // });
  }

  final GlobalKey expansionTileKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  String fullName = '';
  Repository repository = Repository();

  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 20);

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

      appointmentListBloc.onAppointmentListSink(
          formatter.format(fromDate), formatter.format(toDate));
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;

      await appointmentListBloc.onAppointmentListSink(
          formatter.format(fromDate), formatter.format(toDate));

      setState(() {});
    }
    return _date;
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

  final _repository = Repository();
  String search = "";
  bool showFilter = false;

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

  @override
  Widget build(BuildContext context) {
    appointmentListBloc.onAppointmentListSink(
        formatter.format(fromDate), formatter.format(toDate));
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
          title: 'Appointments',
          menuItem: 'assets/svg/Arrow_alt_left.svg',
          // action: 'assets/svg/add.svg',
          // action2: 'assets/svg/Alert.svg'
        ),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
            child: _customcontainer(),
          ),
        ),
      ),
    );
  }

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    formatter.format(DateTime(DateTime.now().year, 12, DateTime.now().day));
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
            child: _carlist(),
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
              fromDate = await selectDate(context, fromDate, 'toDate');

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

  Widget _carlist() {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<AppoiementListModel>(
        stream: appointmentListBloc.AppointmentListStream,
        builder: (context,
            AsyncSnapshot<AppoiementListModel> appointmentlistSnapshot) {
          if (!appointmentlistSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return appointmentlistSnapshot.data!.data!.length == 0
              ? Text(
                  'No Data Found',
                  style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                )
              //: garages.isEmpty
              //  ? Center(child: CircularProgressIndicator())

              : Container(
                  height: double.infinity,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: appointmentlistSnapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        DateTime dateToCheck = DateTime.parse(
                            appointmentlistSnapshot
                                .data!.data![index].appointmentTime!
                                .replaceAll('/', '-')
                                .substring(0, 10));

                        return (appointmentlistSnapshot
                                        .data!.data![index].bookingId!
                                        .contains(search) ||
                                    appointmentlistSnapshot
                                        .data!.data![index].customerName!
                                        .toLowerCase()
                                        .contains(search.toLowerCase()) ||
                                    appointmentlistSnapshot
                                        .data!.data![index].customerId!
                                        .contains(search)) &&
                                ((dateToCheck.isAfter(fromDate) ||
                                        dateToCheck
                                            .isAtSameMomentAs(fromDate)) &&
                                    (dateToCheck.isBefore(toDate) ||
                                        dateToCheck.isAtSameMomentAs(toDate)))
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: appointmentlistSnapshot
                                                          .data!
                                                          .data![index]
                                                          .carImage! ==
                                                      ''
                                                  ? Image.asset(
                                                      'assets/Group 9389.png',
                                                      fit: BoxFit.fitWidth,
                                                    )
                                                  : Image.network(
                                                      appointmentlistSnapshot
                                                          .data!
                                                          .data![index]
                                                          .carImage!,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Icon(Icons.error),
                                                    )),
                                          SizedBox(height: 10.h),
                                          carddivider(
                                              "Customer Name",
                                              appointmentlistSnapshot.data!
                                                  .data![index].customerName!),
                                          SizedBox(height: 5.h),
                                          carddivider(
                                              "Booking Id",
                                              appointmentlistSnapshot.data!
                                                  .data![index].bookingId!),
                                          SizedBox(height: 5.h),
                                          carddivider(
                                              "Garage Name",
                                              appointmentlistSnapshot.data!
                                                  .data![index].garageProfile!),
                                        ],
                                      ),
                                      SizedBox(width: 10.w),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 1.7),
                                              child: Text(
                                                "Appointment Time",
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontFamily: 'Poppins3',
                                                  fontSize: 11.sp,
                                                ),
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
                                                  width: 5,
                                                ),
                                                Text(
                                                  appointmentlistSnapshot
                                                      .data!
                                                      .data![index]
                                                      .appointmentTime!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins3',
                                                    fontSize: 9.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            //TODO DATA BOOKING
                                                            BookingListShow(
                                                                bookingid:
                                                                    appointmentlistSnapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .bookingId)));
                                              },
                                              child: Container(
                                                width: size.width * 0.3,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: logoBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  'View Details',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins3',
                                                      fontSize: 11.sp,
                                                      color: white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            GestureDetector(
                                              onTap: () {
                                                if (appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus ==
                                                        "1" &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus !=
                                                        null) {
                                                  print(appointmentlistSnapshot
                                                      .data!
                                                      .data![index]
                                                      .jobDate);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Text("Info"),
                                                            content: Text(
                                                                "Pickup already accepted. You can not update now!"),
                                                            actions: [
                                                              new TextButton(
                                                                child:
                                                                    const Text(
                                                                        "Ok"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          ));
                                                } else if ((appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .pickupStatus ==
                                                            "0" &&
                                                        appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .pickupStatus !=
                                                            null) ||
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus ==
                                                        "4") {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PickCarUpPage(
                                                                bookingid:
                                                                    appointmentlistSnapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .bookingId,
                                                              )));
                                                }
                                              },
                                              child: Container(
                                                // height: size.height * 0.034,
                                                width: size.width * 0.3,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: (appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .pickupStatus ==
                                                                  "0" &&
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .pickupStatus !=
                                                                  null) ||
                                                          appointmentlistSnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .pickupStatus ==
                                                              "4"
                                                      ? logoBlue
                                                      : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  'Pickup Car',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins3',
                                                      fontSize: 11.sp,
                                                      color: white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            GestureDetector(
                                              onTap: () {
                                                log(appointmentlistSnapshot
                                                    .data!.data![index].garageId
                                                    .toString());

                                                if ((appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .pickupStatus ==
                                                            "1" &&
                                                        appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .pickupStatus !=
                                                            null &&
                                                        appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .jobDate ==
                                                            "") ||
                                                    (appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .jobCardStatus ==
                                                            '2' ||
                                                        appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .jobCardStatus ==
                                                            '0')) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  CreateJobCard(
                                                                    recreate: appointmentlistSnapshot.data!.data![index].jobCardStatus! ==
                                                                            '2'
                                                                        ? true
                                                                        : false,
                                                                    garage_id: appointmentlistSnapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .garageId,
                                                                    job_number: appointmentlistSnapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .jobNumber,
                                                                    booking_id: appointmentlistSnapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .bookingId,
                                                                  )));
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    "Info"),
                                                                content: appointmentlistSnapshot.data!.data![index].jobDate !=
                                                                            "" ||
                                                                        appointmentlistSnapshot.data!.data![index].jobCardStatus ==
                                                                            '1'
                                                                    ? Text(
                                                                        "Job Card has been already created!")
                                                                    : Text(
                                                                        "Job Card can't be created until Customer Confirms pickup!"),
                                                                actions: [
                                                                  new TextButton(
                                                                    child:
                                                                        const Text(
                                                                            "Ok"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              ));
                                                }
                                              },
                                              child: Container(
                                                // height: size.height * 0.034,
                                                width: size.width * 0.3,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: (appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .pickupStatus ==
                                                                  "1" &&
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .pickupStatus !=
                                                                  null &&
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .jobDate ==
                                                                  "") ||
                                                          (appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .jobCardStatus ==
                                                                  '2' ||
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .jobCardStatus ==
                                                                  '0')
                                                      ? logoBlue
                                                      : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .jobCardStatus! ==
                                                          '2'
                                                      ? 'Recreate Job Card'
                                                      : 'Create Job Card',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins3',
                                                      fontSize: 11.sp,
                                                      color: white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            GestureDetector(
                                              onTap: () {
                                                print(appointmentlistSnapshot
                                                    .data!
                                                    .data![index]
                                                    .deliveryStatus);
                                                if (appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus ==
                                                        "2" &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .deliveryStatus ==
                                                        "1" &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .deliveryStatus !=
                                                        null &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus !=
                                                        null) {
                                                  print("again?");
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Text("Info"),
                                                            content: Text(
                                                                "You have already asked for Delivery Confirmation, Do you want to ask again?"),
                                                            actions: [
                                                              new TextButton(
                                                                child:
                                                                    const Text(
                                                                        "Yes"),
                                                                onPressed: () {
                                                                  onSendNotificationAPI(
                                                                      appointmentlistSnapshot
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .bookingId);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              new TextButton(
                                                                child:
                                                                    const Text(
                                                                        "No"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ));
                                                } else if (appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus ==
                                                        "2" &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .deliveryStatus ==
                                                        "0" &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .deliveryStatus !=
                                                        null &&
                                                    // appointmentlistSnapshot.data!
                                                    //         .data![index].garageId !=
                                                    //     null &&
                                                    appointmentlistSnapshot
                                                            .data!
                                                            .data![index]
                                                            .pickupStatus !=
                                                        null) {
                                                  print("first time");
                                                  onSendNotificationAPI(
                                                      appointmentlistSnapshot
                                                          .data!
                                                          .data![index]
                                                          .bookingId);
                                                }
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) => CheckboxPage()),
                                                // );
                                              },
                                              child: Container(
                                                //height: size.height * 0.034,
                                                width: size.width * 0.3,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: (appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .deliveryStatus ==
                                                                  "0" ||
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .deliveryStatus ==
                                                                  "1") &&
                                                          (appointmentlistSnapshot.data!.data![index].deliveryStatus != null &&
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .garageId !=
                                                                  null &&
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .deliveryScheduled !=
                                                                  null)
                                                      ? logoBlue
                                                      : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  appointmentlistSnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .deliveryStatus ==
                                                              "2" ||
                                                          appointmentlistSnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .deliveryStatus ==
                                                              "4"
                                                      ? 'Delivery Confirmed'
                                                      : 'Confirm Delivery',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins3',
                                                      fontSize: 11.sp,
                                                      color: white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            if (appointmentlistSnapshot
                                                        .data!
                                                        .data![index]
                                                        .deliveryStatus ==
                                                    '2' ||
                                                appointmentlistSnapshot
                                                        .data!
                                                        .data![index]
                                                        .deliveryStatus ==
                                                    '4')
                                              GestureDetector(
                                                onTap: () {
                                                  switch (
                                                      appointmentlistSnapshot
                                                          .data!
                                                          .data![index]
                                                          .deliveryStatus) {
                                                    case '2':
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            PaymentMethodDialog(
                                                                jobNo: appointmentlistSnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .jobNumber!),
                                                      );
                                                      break;

                                                    case '4':
                                                      snackBar(
                                                          'Payment method already added');
                                                      break;

                                                    default:
                                                      snackBar(
                                                          'Something went wrong, try again');
                                                      break;
                                                  }
                                                },
                                                child: Container(
                                                  //  height: size.height * 0.034,
                                                  width: size.width * 0.3,
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: appointmentlistSnapshot
                                                                .data!
                                                                .data![index]
                                                                .deliveryStatus ==
                                                            "2"
                                                        ? logoBlue
                                                        : Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    'Payment Method',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins3',
                                                        fontSize: 11.sp,
                                                        color: white),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceEvenly,
                                        children: [
                                          carddivider(
                                              "Payment:",
                                              appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .paymentStatus ==
                                                          "1" &&
                                                      appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .paymentStatus !=
                                                          null
                                                  ? "Paid"
                                                  : "unpaid"),
                                          SizedBox(height: 5.h),
                                          carddivider(
                                              "Pickup:",
                                              appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .pickupStatus ==
                                                          "1" &&
                                                      appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .garageId !=
                                                          null
                                                  ? "Yes"
                                                  : (appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .pickupStatus ==
                                                                  "0" ||
                                                              appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .pickupStatus ==
                                                                  "3") &&
                                                          appointmentlistSnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .pickupStatus !=
                                                              null
                                                      ? "No"
                                                      : appointmentlistSnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .pickupStatus ==
                                                              "4"
                                                          ? "Rejected"
                                                          : "Yes"),
                                          SizedBox(height: 5.h),
                                          carddivider(
                                              'Job Card Status:',
                                              appointmentlistSnapshot
                                                          .data!
                                                          .data![index]
                                                          .jobCardStatus! ==
                                                      'null'
                                                  ? 'Pending'
                                                  : appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .jobCardStatus! ==
                                                          '0'
                                                      ? 'Created'
                                                      : appointmentlistSnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .jobCardStatus! ==
                                                              '1'
                                                          ? 'Paid'
                                                          : appointmentlistSnapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .jobCardStatus! ==
                                                                  '2'
                                                              ? 'Cancelled'
                                                              : ''),
                                          SizedBox(height: 5.h),
                                          carddivider(
                                              "Delivery Scheduled:",
                                              appointmentlistSnapshot
                                                          .data!
                                                          .data![index]
                                                          .deliveryScheduled !=
                                                      null
                                                  ? appointmentlistSnapshot
                                                      .data!
                                                      .data![index]
                                                      .deliveryScheduled
                                                      .toString()
                                                  : "No"),
                                          SizedBox(height: 5.h),
                                          carddivider(
                                              "Delivery:",
                                              appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .deliveryStatus ==
                                                          "2" ||
                                                      appointmentlistSnapshot
                                                              .data!
                                                              .data![index]
                                                              .deliveryStatus ==
                                                          "4"
                                                  ? "Yes"
                                                  : "No"),
                                          SizedBox(height: 5.h),
                                          if (appointmentlistSnapshot
                                                      .data!
                                                      .data![index]
                                                      .deliveryStatus ==
                                                  '2' ||
                                              appointmentlistSnapshot
                                                      .data!
                                                      .data![index]
                                                      .deliveryStatus ==
                                                  '4')
                                            carddivider(
                                                "Payment Method:",
                                                appointmentlistSnapshot
                                                    .data!
                                                    .data![index]
                                                    .paymentMethod!),
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
        });
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

  dynamic onSendNotificationAPI(String? bookingId) async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationCustomerModel isCustomer =
        await _repository.onSendNotificationAPI(
            bookingId!,
            'Please Confirm Delivery',
            'Admin asked for delivery confirmation. please confirm from job progress page');
    print(isCustomer);
    if (isCustomer.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
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
