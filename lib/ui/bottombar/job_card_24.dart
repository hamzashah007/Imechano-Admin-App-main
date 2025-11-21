import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/jobcard_list_bloc.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/model/jobcard_list_model.dart';
import 'package:imechano_admin/ui/screens/drawer/my_job.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:intl/intl.dart';

class JobCardTwentyfour extends StatefulWidget {
  const JobCardTwentyfour({Key? key}) : super(key: key);

  @override
  _JobCardTwentyfourState createState() => _JobCardTwentyfourState();
}

class _JobCardTwentyfourState extends State<JobCardTwentyfour> {
  bool showFilter = false;

  void selectFirstDate() async {
    fromDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    toDate = DateTime(DateTime.now().year, 12, DateTime.now().day);

    formatter.format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
    setState(() {});
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
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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

  String search = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobcardListBloc.onJobcardListSink();
    selectFirstDate();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => WillPopScope(
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
                backgroundColor: logoBlue,
                appBar: WidgetAppBar(
                  title: 'Job Cards',
                  menuItem: 'assets/svg/Arrow_alt_left.svg',
                  // action: 'assets/svg/add.svg',
                  // action2: 'assets/svg/Alert.svg'
                ),
                body: Container(
                    height: double.infinity,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        _searchfilterwidget(),
                        if (showFilter) ...[
                          // These children are only visible if condition is true
                          SizedBox(height: 15.h),
                          _filterwidget(),
                        ],
                        Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.disallowIndicator();
                            return true;
                          },
                          child: SingleChildScrollView(
                              child: Center(child: table())),
                        )),
                      ],
                    )),
              ),
            ));
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
          border: Border.all(
            color: greycolorfont,
          )),
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

  Widget table() {
    return StreamBuilder<JobcardlistModel>(
        stream: jobcardListBloc.JobcardListStream,
        builder:
            (context, AsyncSnapshot<JobcardlistModel> jobcardlistSnapshot) {
          if (!jobcardlistSnapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(color: buttonBlueBorder),
              ),
            );
          }
          List<Data>? filteredData;
          if (jobcardlistSnapshot.hasData) {
            if (search.length == 0) {
              filteredData = jobcardlistSnapshot.data!.data!;
            } else {
              filteredData = jobcardlistSnapshot.data!.data!
                  .where((item) => (item.jobNumber!.contains(search) ||
                      item.customerName!
                          .toLowerCase()
                          .contains(search.toLowerCase()) ||
                      item.customerContactNo!.contains(search) ||
                      item.bookingID!.contains(search)))
                  .toList();
            }

            if (showFilter == true) {
              filteredData = filteredData
                  .where((item) => ((DateTime.parse(item.bookingTime!
                                  .replaceAll('/', '-')
                                  .substring(0, 10))
                              .isAfter(fromDate) ||
                          DateTime.parse(item.bookingTime!.replaceAll('/', '-').substring(0, 10))
                              .isAtSameMomentAs(fromDate)) &&
                      (DateTime.parse(item.bookingTime!.replaceAll('/', '-').substring(0, 10))
                              .isBefore(toDate) ||
                          DateTime.parse(
                                  item.bookingTime!.replaceAll('/', '-').substring(0, 10))
                              .isAtSameMomentAs(toDate))))
                  .toList();
            }
          }

          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: cardgreycolor2)),
                child: filteredData!.length == 0
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            'No Data Found',
                            style: TextStyle(
                                fontFamily: 'Poppins1', fontSize: 18.sp),
                          ),
                        ),
                      )
                    : Center(
                        child: DataTable(
                          showBottomBorder: true,
                          headingRowColor:
                              MaterialStateColor.resolveWith((states) => white),
                          columnSpacing: 10.w,
                          dataRowHeight: 56,
                          dividerThickness: 2,
                          horizontalMargin: 10.h,
                          columns: [
                            DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'JOB ID',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                numeric: false),
                            DataColumn(label: _verticalDivider),
                            // DataColumn(label: Text("Shoaib")),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                'CX NAME',
                                style: TextStyle(
                                    fontSize: 11.sp, fontFamily: "Poppins4"),
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(label: _verticalDivider),
                            DataColumn(
                                label: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'MOBILE',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'NUMBER',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                            DataColumn(label: _verticalDivider),
                            DataColumn(
                                label: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'GARAGE',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'PROFILE',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                            DataColumn(label: _verticalDivider),
                            DataColumn(
                                label: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                            DataColumn(label: _verticalDivider),

                            DataColumn(
                                label: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Booking',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Id',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "Poppins4"),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                            DataColumn(label: _verticalDivider),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                'SEE FULL DETAILS',
                                style: TextStyle(
                                    fontSize: 11.sp, fontFamily: "Poppins4"),
                                textAlign: TextAlign.center,
                              ),
                            )),
                          ],
                          rows: List.generate(
                            filteredData.length,
                            (index) {
                              return DataRow(
                                  color:
                                      MaterialStateColor.resolveWith((states) {
                                    return index % 2 == 0
                                        ? Color(0xFFF5FAFF)
                                        : white; //make tha magic!
                                  }),
                                  cells: [
                                    DataCell(Center(
                                      child: Text(
                                        filteredData![index].id!,
                                        // jobId[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Text(
                                        filteredData[index]
                                            .customerName
                                            .toString(),
                                        // cxName[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Text(
                                        jobcardlistSnapshot.data!.data![index]
                                            .customerContactNo
                                            .toString(),
                                        // moNo[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            jobcardlistSnapshot.data!
                                                .data![index].garageProfile
                                                .toString(),
                                            // garagePro[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: "Poppins3"),
                                          )
                                        ],
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            jobcardlistSnapshot.data!
                                                .data![index].bookingTime!,
                                            //     .substring(0, 9)
                                            //     .toString() +
                                            // " \n" +
                                            // jobcardlistSnapshot.data!
                                            //     .data![index].bookingTime!
                                            //     .substring(10, 15),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: "Poppins3"),
                                          )
                                        ],
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            jobcardlistSnapshot
                                                .data!.data![index].bookingID
                                                .toString(),
                                            // garagePro[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontFamily: "Poppins3"),
                                          )
                                        ],
                                      ),
                                    )),
                                    DataCell(_verticalDivider),
                                    DataCell(button(jobcardlistSnapshot, index))
                                  ]);
                            },
                          ),
                        ),
                      ),
              ));
        });
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget button(
      AsyncSnapshot<JobcardlistModel> jobcardlistSnapshot, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: logoBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text("View Details"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyJobCard(
                        job_number: jobcardlistSnapshot
                            .data!.data![index].jobNumber
                            .toString(),
                      )));
        },
      ),
    );
  }
}
