import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bottombar/Garagejobcard.dart';
import 'package:imechano_admin/ui/bottombar/appointment_page.dart';
import 'package:imechano_admin/ui/bottombar/cx-data_page.dart';
import 'package:imechano_admin/ui/bottombar/dead.dart';
import 'package:imechano_admin/ui/bottombar/garage-profiles.dart';
import 'package:imechano_admin/ui/bottombar/garage_invoice_page.dart';
import 'package:imechano_admin/ui/bottombar/job_card_24.dart';
import 'package:imechano_admin/ui/bottombar/part_shops_invoice_page.dart';
import 'package:imechano_admin/ui/bottombar/pickup_schedule_page.dart';
import 'package:imechano_admin/ui/bottombar/search_screen.dart';
import 'package:imechano_admin/ui/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:imechano_admin/ui/share_preferences/preference.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_drawer_widget.dart';

import 'AssignedTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: drawerpage(),
        backgroundColor: logoBlue,
        appBar: WidgetAppBar(
            title: 'Dashboard',
            menuItem: 'assets/svg/Menu.svg',
            // action: 'assets/svg/add.svg',
            action2: 'assets/svg/Alert.svg'),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => Container(
            padding: EdgeInsets.only(top: 8),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   MyJobCard(job_number: '407')));
                    //     },
                    //     child: Text("Job Card")),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CxDataPage();
                            }));
                          },
                          child: containerCard("assets/cx-data.png", "Cx-Data",
                              Color(0xffEAE7FC)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GarageProfile()));
                          },
                          child: containerCard("assets/garage-profiles.png",
                              "Garage Profile", Color(0xffdae2ef)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobCardTwentyfour()));
                          },
                          child: containerCard("assets/Image 1.png",
                              "Cx Job Cards", Color(0xffECF3FC)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ourServiceCard1(context),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppointmentPage()));
                          },
                          child: containerCard("assets/appointments.png",
                              "Appointments", Color(0xffDCEEFF)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeadBookings()));
                          },
                          child: containerCard("assets/diamond_2.png", "Dead",
                              Color(0xffdae2ef)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AssingedTab()));
                          },
                          child: containerCard("assets/assiged.png", "Assigned",
                              Color(0xffFFEBEC)),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ourServiceCard2(context),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.3,
                              margin: EdgeInsets.only(left: 10.w, top: 5.h),
                              decoration: BoxDecoration(
                                  color: Color(0xff4523ED),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.h))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5),
                                    child: Text(
                                      "Reports",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily: "Poppins1",
                                          color: white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Image(
                                      height: 61,
                                      image: AssetImage(
                                          "assets/Page_perspective_matte.png")),
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget ourServiceCard1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 10.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PartShopsInvoicePage()));
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.14,
                decoration: BoxDecoration(
                    color: Color(0xffFEE9D8),
                    borderRadius: BorderRadius.all(Radius.circular(15.h))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Part Shops",
                            style: TextStyle(
                                fontSize: 13.sp, fontFamily: "Poppins1"),
                          ),
                          Text(
                            "Invoices",
                            style: TextStyle(
                                fontSize: 13.sp, fontFamily: "Poppins1"),
                          ),
                        ],
                      ),
                      Image(
                          height: 65.h,
                          image: AssetImage(
                              "assets/icons/home/oil-change-service.png"))
                    ],
                  ),
                )),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PickupSchedulePage()));
          },
          child: Container(
              margin: EdgeInsets.only(right: 10.w),
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                  color: Color(0xffC7D0FF),
                  borderRadius: BorderRadius.all(Radius.circular(15.h))),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Incoming",
                          style: TextStyle(
                              fontSize: 13.sp, fontFamily: "Poppins1"),
                        ),
                        Text(
                          "Booking",
                          style: TextStyle(
                              fontSize: 13.sp, fontFamily: "Poppins1"),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(height: 98.h, image: AssetImage("assets/pickup.png"))
                  ],
                ),
              )),
        )),
      ],
    );
  }

  Widget ourServiceCard2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return GarageJobCards();
                },
              ));
            },
            child: Container(
                margin: EdgeInsets.only(left: 10.w),
                height: MediaQuery.of(context).size.height * 0.14,
                decoration: BoxDecoration(
                    color: Color(0xffFFF3D5),
                    borderRadius: BorderRadius.all(Radius.circular(20.h))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 6.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Garage Job",
                            style: TextStyle(
                                fontSize: 13.sp, fontFamily: "Poppins1"),
                          ),
                          Text(
                            "Cards",
                            style: TextStyle(
                                fontSize: 13.sp, fontFamily: "Poppins1"),
                          ),
                        ],
                      ),
                      Spacer(),
                      Image(
                          height: 94.h,
                          image: AssetImage("assets/garage-job.png"))
                    ],
                  ),
                )),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GarageInvoicePage()));
          },
          child: Container(
              margin: EdgeInsets.only(right: 10.w),
              height: MediaQuery.of(context).size.height * 0.14,
              decoration: BoxDecoration(
                  color: Color(0xffE5FFD5),
                  borderRadius: BorderRadius.all(Radius.circular(20.h))),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Garage",
                          style: TextStyle(
                              fontSize: 13.sp, fontFamily: "Poppins1"),
                        ),
                        Text(
                          "Invoices",
                          style: TextStyle(
                              fontSize: 13.sp, fontFamily: "Poppins1"),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                        height: 100.h,
                        image: AssetImage("assets/garage-invoice.png"))
                  ],
                ),
              )),
        )),
      ],
    );
  }

  Widget containerCard(String image, String title, Color colors) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.only(
        top: 4.h,
        bottom: 4.h,
      ),
      decoration: BoxDecoration(
          color: colors, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$title",
            style: TextStyle(fontSize: 13.sp, fontFamily: "Poppins1"),
          ),
          Image(height: 88.h, image: AssetImage("$image"))
        ],
      ),
    );
  }

  Widget photoBanner() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(7.h),
        height: 90.h,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/icons/home/Group 9251.png")),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.w, top: 15.h),
              child: Text(
                "Find Auto Service Near You",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, top: 12.h),
              child: Text(
                "Free Pick-up and delivery fees to the location specify",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, top: 8.h),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Color(0xff1840db),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              height: 20.h,
              child: Container(
                margin: EdgeInsets.only(top: 2.5.h, left: 5.w, right: 5.w),
                child: Text(
                  "Get 30% OFF",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomshitMenu(String title, int number) {
    return Container(
      margin: EdgeInsets.only(top: 6.h, bottom: 6.h),
      decoration: BoxDecoration(
          color: Color(0xfff4f5f7),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      alignment: Alignment.centerLeft,
      height: 50.h,
      child: Container(
          margin: EdgeInsets.only(left: 20.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "$title",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 10.w),
                  child: Text(
                    "$number",
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.w800),
                  )),
              Container(
                margin: EdgeInsets.only(right: 20.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.h,
                ),
              ),
            ],
          )),
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
                      PrefObj.preferences?.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => SignInScreen()));
                    })
              ],
            ),
          ],
        );
      },
    );
  }

  Widget alertBox() {
    return Card(
      elevation: 100,
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 50.h, bottom: 378.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
            height: 40.h,
            decoration: BoxDecoration(
                color: Color(0xffa2bdd1),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0))),
            child: Row(
              children: [
                SizedBox(width: 10),
                Image(
                  image: AssetImage("assets/icons/My Account/Group 8349.png"),
                  height: 30.h,
                ),
                SizedBox(width: 10),
                Text(
                  "IMechano Notification",
                  style: TextStyle(
                    color: Color(0xfffff9f9),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "22m ago",
                  style: TextStyle(
                    color: Color(0xfffff9f9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffa5a8aa),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Hey lorriy this remander that one oil change",
                        style: TextStyle(
                            color: Color(0xffdbddde), fontSize: 13.sp),
                      ),
                      Text(
                        "services request through Imachano make",
                        style: TextStyle(
                            color: Color(0xffdbddde), fontSize: 13.sp),
                      ),
                      Text(
                        "sure you tune in on17 july. 6 pm check \nthe service hope understand",
                        style: TextStyle(
                            color: Color(0xffdbddde), fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20.w, top: 15.h, bottom: 5.h),
                    child: Text(
                      "Press for More",
                      style: TextStyle(
                          color: Color(0xffece8e8),
                          fontWeight: FontWeight.w800,
                          fontSize: 15.sp),
                    ))
              ],
            ),
          ),
        ],
      ),
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
