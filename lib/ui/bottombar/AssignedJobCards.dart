import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/jobcard_list_bloc.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/model/jobcard_list_model.dart';
import 'package:imechano_admin/ui/screens/drawer/my_job.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class AssignedJobCards extends StatefulWidget {
  const AssignedJobCards({Key? key, this.garageID, this.garageNmae})
      : super(key: key);

  final String? garageID;
  final String? garageNmae;
  @override
  _AssignedJobCardsState createState() => _AssignedJobCardsState();
}

class _AssignedJobCardsState extends State<AssignedJobCards> {
  List jobId = [
    '12210112',
  ];
  List cxName = [
    'Mukesh Bhati',
  ];
  List moNo = [
    '+123-9584651',
  ];
  List garagePro = [
    'Imechano Service',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobcardListBloc.onJobcardListSink(garageId: widget.garageID);
  }

  @override
  Widget build(BuildContext context) {
    jobcardListBloc.onJobcardListSink(garageId: widget.garageID);

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
                  title: widget.garageNmae ?? "Garage",
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

  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.arrow_left,
            color: cardgreycolor,
          ),
          Center(
              child: Text(
            "Previous",
            style: TextStyle(fontSize: 13.sp, color: grayE6E6E5),
          )),
          SizedBox(width: 3.h),
          VerticalDivider(),
          SizedBox(width: 3.h),
          card(
              "Filter",
              Icon(
                Icons.filter_list_alt,
                size: 17,
                color: logoBlue,
              )),
          SizedBox(width: 3.h),
          VerticalDivider(),
          SizedBox(width: 3.h),
          card("Short", Icon(Icons.filter_list, size: 17, color: logoBlue)),
          SizedBox(width: 3.h),
          VerticalDivider(),
          SizedBox(width: 3.h),
          Center(
              child: Text("Next",
                  style: TextStyle(fontSize: 13.sp, color: logoBlue))),
          Icon(Icons.arrow_right, color: logoBlue),
        ],
      ),
    );
  }

  Widget card(String title, Icon icon123) {
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cardgreycolor)),
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
          if (search.length == 0) {
            filteredData = jobcardlistSnapshot.data!.data;
          } else {
            filteredData = jobcardlistSnapshot.data!.data!
                .where((element) =>
                    element.jobNumber!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    element.customerName!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    element.garageId!.contains(search) ||
                    element.customerContactNo!
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    element.bookingTime!
                        .toLowerCase()
                        .contains(search.toLowerCase()))
                .toList();
          }

          return filteredData!.length == 0
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: cardgreycolor2)),
                    child: Center(
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
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
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
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'NUMBER',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
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
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Time',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
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
                            print("SDASdasdasdadasd");
                            print(jobcardlistSnapshot
                                .data!.data![index].garageId!);

                            return filteredData![index].garageId ==
                                    widget.garageID
                                ? DataRow(
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                        DataCell(Center(
                                          child: Text(
                                            filteredData[index].id.toString(),
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
                                            filteredData[index]
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
                                                filteredData[index]
                                                        .bookingTime!
                                                        .substring(0, 10)
                                                        .toString() +
                                                    " \n" +
                                                    filteredData[index]
                                                        .bookingTime!
                                                        .substring(12, 16),
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
                                        DataCell(
                                            button(jobcardlistSnapshot, index))
                                      ])
                                : DataRow(
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                        DataCell(Center(
                                          child: Text(
                                            "",
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
                                            "",
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
                                            "",
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
                                                "",
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
                                        DataCell(Text(""))
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
        // ignore: deprecated_member_use
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: logoBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            print('Tapped View Details for job at index: ' + index.toString());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyJobCard(
                          job_number: jobcardlistSnapshot
                              .data!.data![index].jobNumber
                              .toString(),
                        )));
          },
          child: Text("View Details"),
        ));
  }
}
