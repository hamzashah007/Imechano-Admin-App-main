// ignore_for_file: must_be_immutable, unnecessary_brace_in_string_interps

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/bottombar/Notification.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/bottombar/job%20card.dart';
import 'package:imechano_admin/ui/provider/notification_count_provider.dart';
import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import 'package:imechano/ui/provider/theme_provider.dart';
// import 'package:imechano/ui/screens/my_account/Notification.dart';
// import 'package:imechano/ui/styling/colors.dart';
// import 'package:imechano_admin/styling/colors.dart';
// import 'package:provider/provider.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? textIconColor;
  final String? imageicon;
  final String? title;
  final double? height;
  final String? menuItem;
  final String? action;
  final String? action2;

  WidgetAppBar({
    this.backgroundColor = logoBlue,
    this.textIconColor = white,
    this.imageicon,
    this.title = '',
    this.menuItem,
    this.height = kToolbarHeight,
    this.action,
    this.action2,
  });
  // dynamic appModelTheme;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Size get preferredSize => Size.fromHeight(height!);
  int count = 98;
  @override
  Widget build(BuildContext context) {
    // final appModel = Provider.of<AppModel>(context);
    // appModelTheme = appModel;
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => AppBar(
        key: _key,
        toolbarHeight: preferredSize.height,
        leadingWidth: 100.w,
        iconTheme: IconThemeData(
          color: textIconColor,
        ),
        leading: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (menuItem!.contains('assets/svg/Arrow_alt_left.svg')) {
                  if (!Navigator.of(context).canPop()) {
                    // If there's no screen in the stack, navigate to home screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBarPage()),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 17),
                  child: SvgPicture.asset('${menuItem}')),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 17),
                  child: SvgPicture.asset('${imageicon}')),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return JobCard();
                },
              ));
            },
            child: Container(
                padding:
                    EdgeInsets.only(top: 15, right: 10, bottom: 15, left: 10),
                child: SvgPicture.asset("${action}",
                    color: Colors.white, height: 20.h, width: 20.w)),
          ),
          if (action2 != null)
            GestureDetector(onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NotificationScreen();
                },
              ));
            }, child: Consumer<NotificationCountProvider>(
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18, right: 15, bottom: 18, left: 10),
                      child: SvgPicture.asset("${action2}",
                          color: Colors.white, height: 25.h, width: 25.w),
                    ),
                    if (value.notifications > 0)
                      Positioned(
                        top: 2,
                        right: 6,
                        child: badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            elevation: 0,
                          ),
                          badgeContent: Text(
                            value.notifications > 99
                                ? '99+'
                                : '${value.notifications}',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          position: badges.BadgePosition.topEnd(top: 0, end: 0),
                          child: SizedBox.shrink(),
                        ),
                      ),
                  ],
                );
              },
            )),
        ],
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Poppins1',
            color: textIconColor,
          ),
        ),
        // backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
        backgroundColor: logoBlue,
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
