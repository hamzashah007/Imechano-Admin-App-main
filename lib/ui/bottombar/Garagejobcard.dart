import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bloc/garage_profile_bloc.dart';
import 'package:imechano_admin/ui/bottombar/AssignedJobCards.dart';
import 'package:imechano_admin/ui/bottombar/garage_profiles_data.dart';
import 'package:imechano_admin/ui/model/garage_profile_model.dart';

class GarageJobCards extends StatefulWidget {
  const GarageJobCards({Key? key}) : super(key: key);

  @override
  _GarageJobCardsState createState() => _GarageJobCardsState();
}

class _GarageJobCardsState extends State<GarageJobCards> {
  void initState() {
    // TODO: implement initState
    super.initState();
    garageProfileAPIBloc.ongarageprofileblocSink();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
              backgroundColor: logoBlue,
              appBar: AppBar(
                leading: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, left: 17),
                          child: SvgPicture.asset(
                              'assets/svg/Arrow_alt_left.svg')),
                    ),
                  ],
                ),

                title: Text(
                  'Garage Job Cards',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Poppins1',
                    color: Colors.white,
                  ),
                ),
                // backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
                backgroundColor: logoBlue,
                centerTitle: true,
                elevation: 0,
              ),
              body: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
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
                        child: SingleChildScrollView(child: table()),
                      )),
                    ],
                  )),
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
            style: TextStyle(fontFamily: "Poppins3", fontSize: 11.sp),
          ),
          icon123 = icon123,
        ],
      ),
    );
  }

  Widget table() {
    return StreamBuilder<GarageProfileModel>(
        stream: garageProfileAPIBloc.GarageProfileStream,
        builder:
            (context, AsyncSnapshot<GarageProfileModel> garageProfileSnapshot) {
          if (!garageProfileSnapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<Data>? filteredData;
          if (search.length == 0) {
            filteredData = garageProfileSnapshot.data!.data;
          } else {
            filteredData = garageProfileSnapshot.data!.data!
                .where((element) => element.garageName!
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
              : Container(
                  width: double.infinity,
                  height: 700,
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 2, color: cardgreycolor2)),
                    child: Center(
                        child: ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AssignedJobCards(
                                          garageID:
                                              filteredData![index].garageId!,
                                          garageNmae:
                                              filteredData[index].garageName!,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as per your requirement
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(filteredData![index].garageName!),
                              ), // Replace YourContentWidget with your own content
                            ),
                          ),
                        );
                      },
                    )
                        // child: DataTable(
                        //   showBottomBorder: false,
                        //   headingRowColor:
                        //       MaterialStateColor.resolveWith((states) => white),
                        //   columnSpacing: 10.w,
                        //   dataRowHeight: 56,
                        //   dividerThickness: 2,
                        //   horizontalMargin: 10.h,
                        //   columns: [
                        //     DataColumn(
                        //         label: Expanded(
                        //           child: Text(
                        //             'GARAGE ID',
                        //             style: TextStyle(
                        //                 fontSize: 11.sp, fontFamily: "Poppins4"),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         ),
                        //         numeric: false),
                        //     DataColumn(label: _verticalDivider),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text(
                        //             'GARAGE',
                        //             style: TextStyle(
                        //                 fontSize: 11.sp, fontFamily: "Poppins4"),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //           Text(
                        //             'NAME',
                        //             style: TextStyle(
                        //                 fontSize: 11.sp, fontFamily: "Poppins4"),
                        //             textAlign: TextAlign.center,
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        //     DataColumn(label: _verticalDivider),
                        //     DataColumn(
                        //         label: Expanded(
                        //       child: Text(
                        //         'Bookings',
                        //         style: TextStyle(
                        //             fontSize: 11.sp, fontFamily: "Poppins4"),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     )),
                        //   ],
                        //   rows: List.generate(
                        //     garageProfileSnapshot.data!.data!.length,
                        //     (index) {
                        //       return DataRow(
                        //           color: MaterialStateColor.resolveWith((states) {
                        //             return index % 2 == 0
                        //                 ? Color(0xFFF5FAFF)
                        //                 : white; //make tha magic!
                        //           }),
                        //           cells: [
                        //             DataCell(Center(
                        //               child: Text(
                        //                 garageProfileSnapshot
                        //                     .data!.data![index].garageId!,
                        //                 textAlign: TextAlign.center,
                        //                 style: TextStyle(
                        //                     fontSize: 11.sp,
                        //                     fontFamily: "Poppins3"),
                        //               ),
                        //             )),
                        //             DataCell(_verticalDivider),
                        //             DataCell(Center(
                        //               child: Column(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     garageProfileSnapshot
                        //                         .data!.data![index].garageName!,
                        //                     textAlign: TextAlign.center,
                        //                     style: TextStyle(
                        //                         fontSize: 11.sp,
                        //                         fontFamily: "Poppins3"),
                        //                   ),
                        //                 ],
                        //               ),
                        //             )),
                        //             DataCell(_verticalDivider),
                        //             DataCell(Padding(
                        //               padding: const EdgeInsets.only(
                        //                   top: 8, bottom: 10),
                        //               // ignore: deprecated_member_use
                        //               child: RaisedButton(
                        //                 textColor: white,
                        //                 child: Text("View Assigned Bookings"),
                        //                 color: logoBlue,
                        //                 onPressed: () {
                        //                   Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                           builder: (context) =>
                        //                               AssignedJobCards(
                        //                                 garageID:
                        //                                     garageProfileSnapshot
                        //                                         .data!
                        //                                         .data![index]
                        //                                         .garageId!,
                        //                                 garageNmae:
                        //                                     garageProfileSnapshot
                        //                                         .data!
                        //                                         .data![index]
                        //                                         .garageName!,
                        //                               )));
                        //                 },
                        //                 shape: new RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       new BorderRadius.circular(10.0),
                        //                 ),
                        //               ),
                        //             ))
                        //           ]);
                        //     },
                        //   ),
                        // ),
                        ),
                  ),
                );
        });
  }

  Widget _verticalDivider =
      const VerticalDivider(color: cardgreycolor2, width: 0.3, thickness: 2);
  Widget button() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: logoBlue,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text("View Details"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GrageProfilesData()));
        },
      ),
    );
  }
}
