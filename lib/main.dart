import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:imechano_admin/firebase_options.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/provider/notification_count_provider.dart';
import 'package:imechano_admin/ui/screens/splash/view/splash_screen.dart';
import 'package:imechano_admin/ui/share_preferences/pref_key.dart';
import 'package:imechano_admin/ui/share_preferences/preference.dart';
import 'package:imechano_admin/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox('iMechano').then(
    (value) => runApp(
      IMechanoApp(prefs: value),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin  ;

class IMechanoApp extends StatefulWidget {
  const IMechanoApp({required this.prefs});
  final Box prefs;

  @override
  State<IMechanoApp> createState() => _IMechanoAppState(prefs: prefs);
}

class _IMechanoAppState extends State<IMechanoApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _IMechanoAppState({required this.prefs});
  Box prefs;

  void notification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  void initState() {
    super.initState();

    print("Printing TOKEN");
    _firebaseMessaging.getToken().then((value) => print(value));
    notification();

    //  when app is totally closed / not opened in the background / terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        log('onMessageOpenedApp data: ${message.data}');
        log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        Utils.handleNotificationNavigation(message, null);
      }
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      log('onMessageOpenedApp data: ${message.data}');
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      Utils.handleNotificationNavigation(message, null);
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      log('onMessageOpenedApp data: ${message.data}');
      log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      Utils.handleNotificationNavigation(message, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationCountProvider())
        ],
        child: GetMaterialApp(
          title: 'iMechano Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: customBlueSwatch,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: dicedeScreen(prefs),
        ),
      ),
    );
  }

  Widget dicedeScreen(Box prefs) {
    PrefObj.preferences = prefs;
    final userStr = prefs.containsKey(PrefKeys.USER_DATA) ? true : false;
    return SplashScreen();
  }
}
