// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';

class PartsShopInvoice extends StatefulWidget {
  const PartsShopInvoice({Key? key}) : super(key: key);

  @override
  _PartsShopInvoiceState createState() => _PartsShopInvoiceState();
}

class _PartsShopInvoiceState extends State<PartsShopInvoice> {
  // Step Counter

  int current_step = 0;
  List partNo = [
    '1',
    '2',
    '3',
  ];
  List partType = [
    'New Org',
    'Used Org',
    'New Org',
  ];
  List partDesc = ['Breack Liner', 'Spring Liner', 'Ball Joint Cuvk'];
  List qty = [
    '4',
    '2',
    '1',
  ];
  List estCost = [
    '2.000',
    '1.000',
    '4.000',
  ];
  List total = [
    '0.00',
    '0.00',
    '0.00',
  ];

  // List2

  List srNo = [
    '1',
    '2',
  ];
  List workDesc = [
    'Lorem Ipsum is simply dummy text of the',
    'Lorem Ipsum has been the industrys standard dumm',
  ];
  List kwdTotal = [
    'KWD 2000',
    'KWD 2000',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () {
        return Scaffold(
          backgroundColor: logoBlue,
          body: Column(
            children: [
              SizedBox(height: 30.h),
              appBarWidget(),
              Expanded(
                child: Stack(
                  children: [
                    _blankContainer(),
                    Container(
                      height: 700.h,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 17.w, right: 17.w),
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(25)),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.h),
                              Container(
                                height: 60.h,
                                // padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/icons/My Account/Group 9252.png"),
                                    )),
                                margin:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CRNo(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                            height: 30.h,
                                            image: AssetImage(
                                                "assets/icons/splash/logo.png"),
                                            color: Colors.white),
                                        Text(
                                          "Powered by Company",
                                          style: TextStyle(
                                              fontSize: 5.sp,
                                              color: white,
                                              fontFamily: "Poppins1"),
                                        )
                                      ],
                                    ),
                                    mobileNumber(),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 10.w,
                                endIndent: 10.w,
                                color: Colors.white,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Parts Repairs-Spares Estimate:   ",
                                        style: TextStyle(
                                            fontFamily: "Poppins1",
                                            fontSize: 13.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    table(),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Container(
                                      child: Text(
                                        "Labour Estimates",
                                        style: TextStyle(
                                            fontFamily: "Poppins1",
                                            fontSize: 13.sp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    tableSecond(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Date: 24-10-2021",
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(12.sp),
                                                fontFamily: "Poppins1"),
                                          ),
                                        ),
                                        totalPart(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        totalLabour(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [estBalance()]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget appBarWidget() {
    return Container(
        height: 120.h,
        color: logoBlue,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(17),
                      child: SvgPicture.asset('assets/svg/Arrow_alt_left.svg')),
                ),
                SizedBox(
                  width: 23.w,
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Parts Shops Invoice",
                        style: TextStyle(
                          color: white,
                          fontSize: 18.sp,
                          fontFamily: "Poppins1",
                        ),
                      )),
                ),
                Row(
                  children: [
                    // Container(
                    //     padding:
                    //         EdgeInsets.only(top: 15, right: 10, bottom: 15),
                    //     child: SvgPicture.asset("assets/svg/add.svg",
                    //         height: 15, width: 15, color: white)),
                    GestureDetector(
                      onTap: () {
                        // Get.to(NotificationScreen());
                      },
                      child: Container(
                        width: 60.w,
                        padding: EdgeInsets.only(
                            top: 20, right: 17, bottom: 20, left: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40.h,
                  margin: EdgeInsets.only(right: 20.w),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: "Poppins1",
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 24.sp,
                          )
                        ],
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget _blankContainer() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: logoBlue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0.w),
            bottomRight: Radius.circular(100.0.w)),
      ),
    );
  }

  Widget table() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showBottomBorder: true,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => Color(0xff162e3f)),
          columnSpacing: 25.w,
          dataRowHeight: 50.h,
          horizontalMargin: 10.w,
          columns: [
            DataColumn(
                label: Expanded(
                  child: Text(
                    'Part\nNo.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                numeric: false),
            DataColumn(
              label: Expanded(
                child: Text('Part\nType',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        fontFamily: "Poppins1")),
              ),
            ),
            DataColumn(
                label: Expanded(
              child: Text('Part\nDesc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Qty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Est\nCost',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp)),
            )),
          ],
          rows: List.generate(
            3,
            (index) {
              return DataRow(
                  color: MaterialStateColor.resolveWith((states) {
                    return index % 2 == 0
                        ? Color(0xFFF5FAFF)
                        : white; //make tha magic!
                  }),
                  cells: [
                    DataCell(Center(
                      child: Text(partNo[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.sp, fontFamily: "Poppins3")),
                    )),
                    DataCell(Center(
                      child: Text(partType[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.sp, fontFamily: "Poppins3")),
                    )),
                    DataCell(Center(
                      child: Text(
                        partDesc[index],
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                        textAlign: TextAlign.center,
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        qty[index],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        estCost[index],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        total[index],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                      ),
                    )),
                  ]);
            },
          ),
        ));
  }

  Widget tableSecond() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: DataTable(
            showBottomBorder: true,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Color(0xff162e3f)),
            columnSpacing: 10.w,
            dataRowHeight: 50.h,
            horizontalMargin: 10.w,
            columns: [
              DataColumn(
                  label: Expanded(
                    child: Text(
                      'Sr\nNo.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins1",
                          fontSize: 11.sp),
                    ),
                  ),
                  numeric: false),
              DataColumn(
                label: Text(
                  'Labour Work\nDescription',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp),
                ),
              ),
              DataColumn(
                  label: Expanded(
                child: Text(
                  'Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins1",
                      fontSize: 11.sp),
                ),
              )),
            ],
            rows: List.generate(
              2,
              (index) {
                return DataRow(cells: [
                  DataCell(
                    Text(
                      srNo[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                    ),
                  ),
                  DataCell(Text(
                    workDesc[index],
                    style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                  )),
                  DataCell(Text(
                    kwdTotal[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.sp, fontFamily: "Poppins3"),
                  )),
                ]);
              },
            ),
          ),
        ));
  }

  Widget CRNo() {
    return Container(
      child: Text(
        "CR No.\n1232334654654",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 10.sp, fontFamily: "Poppins1"),
      ),
      margin: EdgeInsets.only(left: 8.w),
    );
  }

  Widget mobileNumber() {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      child: Text(
        "Telephone No.\n+9125-2543-25",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 10.sp, fontFamily: "Poppins1"),
      ),
    );
  }

  Widget customerDetails() {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Details",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/icons/My Vehicle/Group 9254.png"),
                height: 70.h,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name:          Mustufa Khan"),
                    Text("Address:      dsfgsdfsdfsdfsdf"),
                    Text("City/State:   Dubai        ")
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget estBalance() {
    return Container(
      margin: EdgeInsets.only(left: 120.w),
      height: 40.h,
      width: 167.w,
      //padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
      alignment: Alignment.center,
      color: Color(0xffdde2f5),
      child: Text(
        "Est Balance: KWD 2.000",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins1", fontSize: 11.sp),
      ),
    );
  }

  Widget totalLabour() {
    return Container(
      margin: EdgeInsets.only(left: 120.w),
      height: 40.h,
      width: 167.w,
      alignment: Alignment.center,
      color: Color(0xffdde2f5),
      child: Text(
        "Total Labour: KWD 10.000",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins1", fontSize: 11.sp),
      ),
    );
  }

  Widget totalPart() {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(6.w)),
      height: 40.h,
      width: 167.w,
      alignment: Alignment.center,
      color: Color(0xffdde2f5),
      child: Text(
        "Total Part: KWD 10.000",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins1", fontSize: 11.sp),
      ),
    );
  }
}
