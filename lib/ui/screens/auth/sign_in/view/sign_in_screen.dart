import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bottombar/bottom_bar.dart';
import 'package:imechano_admin/ui/model/login_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/share_preferences/pref_key.dart';
import 'package:imechano_admin/ui/share_preferences/preference.dart';
import 'package:imechano_admin/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano_admin/ui/shared/widgets/form/custom_form.dart';
import 'package:imechano_admin/ui/shared/widgets/text_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _repository = Repository();
  bool showPassword = true;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String fcmToken = '';

  @override
  void initState() {
    firebaseCloudMessaging_Listeners();
    super.initState();
  }

  void firebaseCloudMessaging_Listeners() async {
    // if (Platform.isIOS) iOS_Permission();

    await _firebaseMessaging.getToken().then((token) {
      print(token);
      fcmToken = token!;
    });
  }

  // void iOS_Permission() {
  //   _firebaseMessaging!.requestPermission(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ScreenUtilInit(
        builder: () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                    SvgPicture.asset(
                      "assets/svg/imechano-logo.svg",
                    ),
                    // Image(image: AssetImage('assets/icons/splash/logo.png')),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      "Login Account",
                      style: TextStyle(
                          fontFamily: "poppins2",
                          fontSize: 27,
                          color: logoBlue),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "with your phone number",
                      style: TextStyle(fontFamily: "poppins1"),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    CustomForm(
                      validationform: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Fil The Mobile No';
                        }
                        return null;
                      },
                      controller: email,
                      imagePath: 'assets/svg/Path 8566.svg',
                      hintText: 'User Name',
                      fillColor: grayE6E6E5,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    _Textfild(),
                    Spacer(),
                    CustomButton(
                      title: Regular20White('Sign In'),
                      width: 12,
                      bgColor: logoBlue,
                      borderColor: buttonBlueBorder,
                      callBackFunction: () {
                        if (_formKey.currentState!.validate()) {
                          validatePassword(password.text);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );
                          onLoginAPI();
                        }
                      },
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    print(value);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  Widget _Textfild() {
    return Container(
      child: TextFormField(
          validator: validatePassword,
          controller: password,
          obscureText: showPassword,
          decoration: InputDecoration(
            fillColor: grayE6E6E5,
            filled: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/svg/Group 9447.svg", height: 18),
            ),
            hintText: "Enter Password",
            hintStyle: TextStyle(fontFamily: 'Poppins3'),
            prefixIconConstraints: BoxConstraints(minWidth: 40),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          )),
    );
  }

  dynamic onLoginAPI() async {
    // show loader
    Loader().showLoader(context);
    final LoginModel? isLogin =
        await _repository.onLogin(email.text, password.text, fcmToken);
    if (isLogin == null) {
      showpopDialog(context, 'Error', 'Cannot login right now');
      Loader().hideLoader(context);
    } else if (isLogin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      print(
          "~~~~~~~~~~~~~~~~~~~~~~~~~~~Login Data Start~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      print(json.encode(isLogin.data));
      print(fcmToken);
      print(
          "~~~~~~~~~~~~~~~~~~~~~~~~~~~Login Data End~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      PrefObj.preferences!.put(PrefKeys.USER_DATA, json.encode(isLogin.data));
      // PrefObj.preferences!.put(PrefKeys.JOB_DATA, json.encode(isLogin.data));
      Loader().hideLoader(context);
      snackBar('Login Successfully!!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBarPage(),
        ),
      );
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isLogin.message != null ? isLogin.message! : '');
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
