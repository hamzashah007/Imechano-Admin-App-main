import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/provider/notification_count_provider.dart';
import 'package:imechano_admin/ui/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:imechano_admin/ui/share_preferences/pref_key.dart';
import 'package:imechano_admin/ui/share_preferences/preference.dart';
import 'package:imechano_admin/ui/shared/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;

    //======SET NOTIFICATIONS OF THE USER ON SPLASH SCREEN
    if (userStr) {
      Provider.of<NotificationCountProvider>(context, listen: false)
          .setNotifications();
    }
    Future.delayed(const Duration(seconds: 7), () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  !userStr ? SignInScreen() : BottomBarPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 20),
                Image(image: AssetImage('assets/icons/splash/logo.png')),
                Regular20Black('Welcome to iMechano Car Service'),
                Image(image: AssetImage('assets/icons/splash/splash.png')),
                Image.asset(
                  'assets/meter.gif',
                  height: 120,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
