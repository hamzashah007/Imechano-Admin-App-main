import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bottombar/appointment_page.dart';
import 'package:imechano_admin/ui/bottombar/customer_enquiry.dart';
import 'package:imechano_admin/ui/bottombar/home_screen.dart';
import 'package:imechano_admin/ui/bottombar/pickup_and%20_fix_page.dart';
import 'package:imechano_admin/ui/bottombar/profile.dart';

class BottomBarPage extends StatefulWidget {
  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int selectedIndex = 2;

  List navigationButtomBar = [
    PickCarUpPage(),
    AppointmentPage(),
    HomeScreen(),
    CustomerEnquiry(),
    ProfilePage()
  ];

  bool selecteicon = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 2,
            height: 60.0,
            items: <Widget>[
              selectedIndex == 0
                  ? SvgPicture.asset("assets/svg/Path 1195.svg",
                      color: Colors.white, height: 28)
                  : SvgPicture.asset("assets/svg/Path 1195.svg",
                      color: Colors.grey, height: 22),
              selectedIndex == 1
                  ? SvgPicture.asset("assets/svg/noun_calender_2189968.svg",
                      color: Colors.white, height: 28)
                  : SvgPicture.asset("assets/svg/noun_calender_2189968.svg",
                      color: Colors.grey, height: 22),
              selectedIndex == 2
                  ? SvgPicture.asset("assets/svg/noun_Home_4334361.svg",
                      color: Colors.white, height: 28)
                  : SvgPicture.asset("assets/svg/noun_Home_4334361.svg",
                      color: Colors.grey, height: 22),
              selectedIndex == 3
                  ? SvgPicture.asset("assets/svg/Path 10947.svg",
                      color: Colors.white, height: 28)
                  : SvgPicture.asset("assets/svg/Path 10947.svg",
                      color: Colors.grey, height: 22),
              selectedIndex == 4
                  ? SvgPicture.asset("assets/svg/Path 8566.svg",
                      color: Colors.white, height: 28)
                  : SvgPicture.asset("assets/svg/Path 8566.svg",
                      color: Colors.grey, height: 22),
            ],
            color: Colors.grey.shade100,
            buttonBackgroundColor: logoBlue,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInExpo,
            animationDuration: Duration(milliseconds: 400),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: navigationButtomBar[selectedIndex]),
    );
  }
}
