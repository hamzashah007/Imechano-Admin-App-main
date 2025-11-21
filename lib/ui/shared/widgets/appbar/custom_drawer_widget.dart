// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bottombar/AssignedTab.dart';
import 'package:imechano_admin/ui/bottombar/appointment_page.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/bottombar/cx-data_page.dart';
import 'package:imechano_admin/ui/bottombar/cx_invoices.dart';
import 'package:imechano_admin/ui/bottombar/dead.dart';
import 'package:imechano_admin/ui/bottombar/garage-profiles.dart';
import 'package:imechano_admin/ui/bottombar/garage_invoice_page.dart';
import 'package:imechano_admin/ui/bottombar/job_card_24.dart';
import 'package:imechano_admin/ui/bottombar/search_screen.dart';
import 'package:imechano_admin/ui/provider/notification_count_provider.dart';
import 'package:imechano_admin/ui/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:imechano_admin/ui/share_preferences/preference.dart';
import 'package:provider/provider.dart';

class drawerpage extends StatefulWidget {
  @override
  State<drawerpage> createState() => _drawerpageState();
}

class _drawerpageState extends State<drawerpage> {
  List drawertitle = [
    "Home",
    "Garage Profile",
    "Cx Data",
    "Booking Action",
    "Cx Job cards",
    "Grg Job cards",
    "Appointments",
    "Cx Invoice",
    "Garage Invoice",
    "Reports",
    "Assign",
    "Dead"
  ];

  List page = [
    BottomBarPage(),
    GarageProfile(),
    CxDataPage(),
    CxDataPage(),
    JobCardTwentyfour(),
    JobCardTwentyfour(),
    // JobCard(),
    AppointmentPage(),
    CxInvoices(),
    GarageInvoicePage(),
    SearchScreen(),
    AssingedTab(),
    DeadBookings()
  ];

  List secondListtitle = [
    "Assigned",
    "Picked Scheduled",
    "Unaswared",
    "Dead",
    "Logout"
  ];

  List drawerIcon = [
    "assets/svg/noun_Home_4334361.svg",
    "assets/svg/manage_accounts_black_24dp.svg",
    "assets/svg/noun-report-3888335.svg",
    "assets/svg/noun_calender_2189968.svg",
    "assets/svg/Group 9336.svg",
    "assets/svg/Desk_alt_fill.svg",
    "assets/svg/dob.svg",
    "assets/svg/noun-invoice-1112950.svg",
    "assets/svg/file-text.svg",
    "assets/svg/noun-report-2254436.svg",
    "assets/svg/Group 9352.svg",
    "assets/svg/noun-dead-349939.svg"
  ];

  List secondlisticon = [
    "assets/icons/drawer/noun-report-2254436.png",
    "assets/icons/drawer/Group 9352.png",
    "assets/icons/drawer/Group 9351.png",
    "assets/icons/drawer/Path 10947.png",
    "assets/icons/drawer/noun-dead-349939.png",
    "assets/icons/drawer/logout_black_24dp.png"
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    // final appModel = Provider.of<AppModel>(context);
    // appModelTheme = appModel;
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Drawer(
        key: _key,
        child: Column(
          children: [
            Container(
              height: 186.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: logoBlue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/icons/drawer/Group 293.png"),
                      height: 85.h,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "James Martine",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat3  ",
                              color: Colors.white,
                              fontSize: 18.sp),
                        ),
                        Text(
                          "+96544548785",
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => page[index]));
                              },
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.only(left: 10.w),
                                  child:
                                      SvgPicture.asset("${drawerIcon[index]}"),
                                ),
                                title: Text(
                                  "${drawertitle[index]}",
                                  style: TextStyle(
                                      fontFamily: "Poppins1", fontSize: 15),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(height: 0, child: Divider());
                          },
                          itemCount: 11),
                      Container(height: 0, child: Divider()),

                      // Container(height: 0, child: Divider()),
                      // ExpansionTile(
                      //   children: [
                      //     Container(
                      //         margin: EdgeInsets.only(left: 80.w),
                      //         alignment: Alignment.topLeft,
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //         ))
                      //   ],
                      //   leading: Container(
                      //     margin: EdgeInsets.only(left: 9.w),
                      //     child: SvgPicture.asset(
                      //       "assets/svg/noun-report-2254436.svg",
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Reports",
                      //     style:
                      //         TextStyle(fontFamily: "Poppins1", fontSize: 15),
                      //   ),
                      // ),
                      // Container(height: 0, child: Divider()),
                      // listtiledrawer("assets/svg/Group 9352.svg", "Assign"),
                      // listtiledrawer(
                      //     "assets/svg/Group 9351.svg", "Pickup Schedule"),
                      // listtiledrawer("assets/svg/noun-dead-349939.svg", "Dead"),
                      GestureDetector(
                        onTap: () {
                          logOutDialog();
                        },
                        child: listtiledrawer(
                            "assets/svg/logout_black_24dp.svg", "Logout"),
                      )
                    ],
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  void logOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Column(
            children: [
              Text(
                "Log out?",
                style: TextStyle(fontFamily: "Poppins2"),
              ),
              SizedBox(height: 15.h),
              Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 15.sp, fontFamily: "Poppins1"),
              )
            ],
          )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: logoBlue,
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontFamily: "Poppins1"),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                    ),
                    child: Text('Log out',
                        style: TextStyle(fontFamily: "Poppins1")),
                    onPressed: () {
                      Provider.of<NotificationCountProvider>(context,
                              listen: false)
                          .setNotifications();
                      PrefObj.preferences?.clear();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                          (Route route) => false);
                    })
              ],
            ),
          ],
        );
      },
    );
  }

  Widget listtiledrawer(String image, String title) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            margin: EdgeInsets.only(left: 9.w),
            child: SvgPicture.asset(
              "$image",
            ),
          ),
          title: Text(
            "$title",
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Poppins1",
            ),
          ),
        ),
        Container(height: 0, child: Divider()),
      ],
    );
  }
}
