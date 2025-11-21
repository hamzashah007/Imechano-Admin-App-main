// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/api/notification_api.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bloc/admin_notification_list_bloc.dart';
import 'package:imechano_admin/ui/model/admin_notification_list_model.dart';
import 'package:imechano_admin/ui/provider/notification_count_provider.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/confirmation_dialog.dart';
import 'package:imechano_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isSwitch = true;

  List notidfication = [
    "Your orders has been picked up",
    "Your order has been delivered",
    "Lorem ipsum dolor sit amet, consectetur",
    "Lorem ipsum dolor sit amet, consectetur",
    "Lorem ipsum dolor sit amet, consectetur",
    "Lorem ipsum dolor sit amet, consectetur",
    "Lorem ipsum dolor sit amet, consectetur",
    "Lorem ipsum dolor sit amet, consectetur",
  ];

  List time = [
    "Now",
    "1 h ago",
    "3 h ago",
    "5h ago",
    "05 Sep 2020",
    "12 Aug 2020",
    "20 Jul 2020",
    "12 Jul 2020"
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<NotificationCountProvider>(context, listen: false)
        .setNotifications();
    adminNotificationListBloc.onnotificationListSink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetAppBar(
          title: 'Notification',
          menuItem: 'assets/svg/Arrow_alt_left.svg',
        ),
        backgroundColor: Color(0xff70bdf1),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0))),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            notificationSwitch(),
                            SizedBox(height: 5.h),
                            StreamBuilder<AdminNotificationListModel>(
                                stream: adminNotificationListBloc
                                    .notificationListStream,
                                builder: (context,
                                    AsyncSnapshot<AdminNotificationListModel>
                                        notificationListSnapshot) {
                                  if (notificationListSnapshot
                                          .connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: buttonBlueBorder,
                                      ),
                                    );
                                  }
                                  return ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: notificationListSnapshot
                                        .data!.data!.length,
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                    itemBuilder: (context, index) {
                                      return Container(
                                        color: notificationListSnapshot.data!
                                                    .data![index].status ==
                                                '1'
                                            ? grayE6E6E5
                                            : greycolorfont.withOpacity(0.5),
                                        child: ListTile(
                                          isThreeLine: true,
                                          onTap: () async {
                                            final notification =
                                                notificationListSnapshot
                                                    .data!.data![index];
                                            log('Notification tapped -> id:${notification.id} title:${notification.title} status:${notification.status} jobNo:${notification.jobNo}');

                                            if (notification.status == '0') {
                                              log('Notification ${notification.id} is unread. Attempting to update status...');
                                              final bool response =
                                                  await NotificationApi
                                                      .updateNotificationStatus(
                                                          notification.id!);
                                              log('Status update for ${notification.id} completed with response: $response');
                                            }

                                            final String? title =
                                                notification.title;
                                            final String? jobNo =
                                                notification.jobNo;
                                            log('Navigating based on notification title:$title jobNo:$jobNo');
                                            Utils.handleNotificationNavigation(
                                                null, title, jobNo);
                                            log('Navigation handler executed for notification ${notification.id}');
                                          },
                                          title: Text(
                                            notificationListSnapshot
                                                    .data!.data![index].title ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'Poppins3'),
                                          ),
                                          subtitle: Text(
                                            notificationListSnapshot
                                                .data!.data![index].message!,
                                          ),
                                          leading: Image(
                                            height: 10,
                                            image: AssetImage(
                                                "assets/icons/My Account/Ellipse 27-1.png"),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget notificationSwitch() {
    return Row(
      children: [
        Container(
          height: 20.h,
          child: Image(
            height: 25.h,
            image: AssetImage(
                "assets/icons/My Account/notifications_black_24dp.png"),
          ),
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
        ),
        Expanded(
          child: Text(
            "Notification",
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ConfirmationDialog(
                        message: 'delete all notifications?',
                        onYesPressed: () async {
                          Loader().showLoader(context);
                          bool response =
                              await NotificationApi.deleteAllNotifications();
                          if (response) {
                            await Provider.of<NotificationCountProvider>(
                                    context,
                                    listen: false)
                                .setNotifications();
                            await adminNotificationListBloc
                                .onnotificationListSink();
                            setState(() {});
                          }

                          Loader().hideLoader(context);
                          Navigator.pop(context);
                        });
                  });
            },
            icon: Icon(Icons.delete, color: red)),
        Switch(
          activeColor: Colors.blue,
          value: isSwitch,
          onChanged: (value) {
            setState(() {
              isSwitch = value;
            });
          },
        )
      ],
    );
  }
}
