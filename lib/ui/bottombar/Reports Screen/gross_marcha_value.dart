import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/customer_list_bloc.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class Grossvalue extends StatefulWidget {
  final String? status;
  const Grossvalue({Key? key, this.status}) : super(key: key);

  @override
  _GrossvalueState createState() => _GrossvalueState();
}

class _GrossvalueState extends State<Grossvalue> {
  List plateNo = [
    'A DUBAI 005',
  ];
  List garageAss = [
    'Imechano Repairs',
  ];
  List carsCustom = [
    'BMW',
  ];
  List garagePro = [
    'Mukesh Bhati',
  ];
  int selectedindex = 1;
  List DataList = [
    ToalCustom(),
    ToalCustom1(),
    ToalCustom2(),
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   customerListBloc.customerListSinck(widget.status.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: WidgetAppBar(
                title: 'Marchandisers',
                menuItem: 'assets/svg/Arrow_alt_left.svg',
                // action: 'assets/svg/add.svg',
                // action2: 'assets/svg/Alert.svg'
              ),
              body: Column(
                children: [
                  Container(
                    height: 40.h,
                    // margin: EdgeInsets.only(right: 5.w),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                            onTap: () {
                              selectedindex = 0;
                              setState(() {});
                            },
                            child: cardreview("All Completed",
                                selectedindex == 0 ? true : false)),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            selectedindex = 1;
                            setState(() {});
                          },
                          child: cardreview(
                              "All Pending", selectedindex == 1 ? true : false),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: white,
                        //       border: Border.all(color: white),
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(8),
                        //       )),
                        //   alignment: Alignment.center,
                        //   width: 150.w,
                        //   child: Padding(
                        //     padding:
                        //         const EdgeInsets.only(left: 15.0, right: 15),
                        //     child: Text(
                        //       "All Pending",
                        //       style: TextStyle(fontFamily: "Poppins1"),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            selectedindex = 2;
                            setState(() {});
                          },
                          child: cardreview("All Canceled",
                              selectedindex == 2 ? true : false),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: DataList[selectedindex],

                    //     NotificationListener<OverscrollIndicatorNotification>(
                    //   onNotification: (notification) {
                    //     notification.disallowGlow();
                    //     return true;
                    //   },
                    //   child: Container(
                    //       width: double.infinity,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.only(
                    //           topRight: Radius.circular(25),
                    //           topLeft: Radius.circular(25),
                    //         ),
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           _filterwidget(),
                    //           Expanded(
                    //               child: NotificationListener<
                    //                   OverscrollIndicatorNotification>(
                    //             onNotification: (notification) {
                    //               notification.disallowGlow();
                    //               return true;
                    //             },
                    //             child: SingleChildScrollView(
                    //                 child: Center(
                    //               child: DataList[selectedindex],
                    //             )),
                    //           )),
                    //         ],
                    //       )),
                    // ),
                  ),
                ],
              ),
            ));
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
        children: [
          new Text(
            title,
            style: TextStyle(fontFamily: "Poppins1", fontSize: 13.sp),
          ),
          SizedBox(width: 5),
          icon123 = icon123,
        ],
      ),
    );
  }

  Widget button() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        // ignore: deprecated_member_use
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: logoBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {},
          child: Text("View Details"),
        ));
  }

  Widget cardreview(String title, bool isselected) {
    return new Container(
      decoration: BoxDecoration(
          color: isselected ? Colors.white : Color(0xff70BDF1),
          border: Border.all(color: white),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 3.1,
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

class ToalCustom extends StatefulWidget {
  const ToalCustom({Key? key}) : super(key: key);

  @override
  State<ToalCustom> createState() => _ToalCustomState();
}

class _ToalCustomState extends State<ToalCustom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerListBloc.customerListSinck('1');
  }

  final _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _filterwidget(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: cardgreycolor2)),
                        child: Center(
                          child: DataTable(
                            showBottomBorder: false,
                            showCheckboxColumn: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 10.w,
                            dataRowHeight: 50,
                            dividerThickness: 2,
                            horizontalMargin: 25.w,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins4"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Parts No.',
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
                                      'Parts Desc.',
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
                                  'Vendor',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'Part Qty',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'Cost',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                            rows: List.generate(
                              5,
                              // customerListSnapshot.data!.data!.length,
                              (index) {
                                return DataRow(
                                    // onSelectChanged: (value) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             PickCarUpPage(
                                    //                 bookingid:
                                    //                     customerListSnapshot
                                    //                         .data!
                                    //                         .data![
                                    //                             index]
                                    //                         .bookingId)),
                                    //   );
                                    // },
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        // customerListSnapshot.data!
                                        //     .data![index].plateNumber!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          // customerListSnapshot.data!
                                          //     .data![index].grageName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   children: [
          //     Icon(
          //       Icons.arrow_left,
          //       color: cardgreycolor,
          //     ),
          //     Center(
          //         child: Text(
          //       "Previous",
          //       style: TextStyle(fontSize: 13.sp, color: grayE6E6E5),
          //     )),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Center(
          //         child: Text("Next",
          //             style: TextStyle(fontSize: 13.sp, color: logoBlue))),
          //     Icon(Icons.arrow_right, color: logoBlue),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class ToalCustom1 extends StatefulWidget {
  const ToalCustom1({Key? key}) : super(key: key);

  @override
  State<ToalCustom1> createState() => _ToalCustom1State();
}

class _ToalCustom1State extends State<ToalCustom1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerListBloc.customerListSinck('0');
  }

  final _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _filterwidget(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: cardgreycolor2)),
                        child: Center(
                          child: DataTable(
                            showBottomBorder: false,
                            showCheckboxColumn: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 10.w,
                            dataRowHeight: 50,
                            dividerThickness: 2,
                            horizontalMargin: 25.w,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins4"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Parts No.',
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
                                      'Parts Desc.',
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
                                  'Vendor',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'Part Qty',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'Cost',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                            rows: List.generate(
                              5,
                              // customerListSnapshot.data!.data!.length,
                              (index) {
                                return DataRow(
                                    // onSelectChanged: (value) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             PickCarUpPage(
                                    //                 bookingid:
                                    //                     customerListSnapshot
                                    //                         .data!
                                    //                         .data![
                                    //                             index]
                                    //                         .bookingId)),
                                    //   );
                                    // },
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        // customerListSnapshot.data!
                                        //     .data![index].plateNumber!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          // customerListSnapshot.data!
                                          //     .data![index].grageName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
            ],
          ),
          Row(
            children: [
              Center(
                  child: Text("Next",
                      style: TextStyle(fontSize: 13.sp, color: logoBlue))),
              Icon(Icons.arrow_right, color: logoBlue),
            ],
          ),
        ],
      ),
    );
  }
}

class ToalCustom2 extends StatefulWidget {
  const ToalCustom2({Key? key}) : super(key: key);

  @override
  State<ToalCustom2> createState() => _ToalCustom2State();
}

class _ToalCustom2State extends State<ToalCustom2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerListBloc.customerListSinck('2');
  }

  final _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _filterwidget(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 2, color: cardgreycolor2)),
                        child: Center(
                          child: DataTable(
                            showBottomBorder: false,
                            showCheckboxColumn: false,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => white),
                            columnSpacing: 10.w,
                            dataRowHeight: 50,
                            dividerThickness: 2,
                            horizontalMargin: 25.w,
                            columns: [
                              DataColumn(
                                  label: Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins4"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  numeric: false),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Parts No.',
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
                                      'Parts Desc.',
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
                                  'Vendor',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'Part Qty',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              DataColumn(label: _verticalDivider),
                              DataColumn(
                                  label: Expanded(
                                child: Text(
                                  'Cost',
                                  style: TextStyle(
                                      fontSize: 11.sp, fontFamily: "Poppins4"),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                            rows: List.generate(
                              5,
                              // customerListSnapshot.data!.data!.length,
                              (index) {
                                return DataRow(
                                    // onSelectChanged: (value) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             PickCarUpPage(
                                    //                 bookingid:
                                    //                     customerListSnapshot
                                    //                         .data!
                                    //                         .data![
                                    //                             index]
                                    //                         .bookingId)),
                                    //   );
                                    // },
                                    color: MaterialStateColor.resolveWith(
                                        (states) {
                                      return index % 2 == 0
                                          ? Color(0xFFF5FAFF)
                                          : white; //make tha magic!
                                    }),
                                    cells: [
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        // customerListSnapshot.data!
                                        //     .data![index].plateNumber!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          // customerListSnapshot.data!
                                          //     .data![index].grageName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                          child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "Poppins3"),
                                      ))),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                      DataCell(_verticalDivider),
                                      DataCell(Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: "Poppins3"),
                                        ),
                                      )),
                                    ]);
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider = const VerticalDivider(
    color: cardgreycolor2,
    width: 0.3,
    thickness: 2,
  );
  Widget _filterwidget() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(right: 5, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
            ],
          ),
          Row(
            children: [
              Center(
                  child: Text("Next",
                      style: TextStyle(fontSize: 13.sp, color: logoBlue))),
              Icon(Icons.arrow_right, color: logoBlue),
            ],
          ),
        ],
      ),
    );
  }
}
