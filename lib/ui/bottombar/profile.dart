// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/form/custom_form.dart';

import '../screens/auth/sign_in/view/sign_in_screen.dart';
import '../share_preferences/preference.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _repository = Repository();
  int _radioSelected = 1;
  var userid = "2";

  String? _radioVal = "male";

  bool isLoading = false;
  var userStr;
  var profileData;
  @override
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  XFile? image, temp;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'My Profile',
        menuItem: 'assets/svg/Menu.svg',
        // action: 'assets/svg/add.svg',
        action2: 'assets/svg/ball.svg',
      ),
      key: _key,
      drawer: drawerpage(),
      backgroundColor: Color(0xff70bdf1),
      body: Form(
        key: _formKey,
        child: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
            child: Column(children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0))),
                    child: _body()),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
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
              SizedBox(height: 10.h),
              _profile(),
              SizedBox(height: 15.h),
              _username(),
              SizedBox(height: 10.h),
              SingleChildScrollView(
                child: _scrollBarWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _body2() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/imechano-logo.svg",
            height: MediaQuery.of(context).size.height * 0.11,
            color: Color(0xff70bdf1),
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: MaterialButton(
              child: Text("Login"),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return SignInScreen();
                //   },
                // ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profile() {
    return Stack(
      children: [
        temp != null
            ? Center(
                child: CircleAvatar(
                  radius: 55.h,
                  backgroundImage: FileImage(
                    File(temp!.path),
                  ),
                ),
              )
            : Center(
                child: CircleAvatar(
                  radius: 55.h,
                  child: Icon(Icons.person, size: 50.sp),
                ),
              ),
        Positioned(
          top: 0.h,
          left: 162.2.w,
          child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 55.h,
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Center(
                        child: Text(
                          "SELECT ANY ONE",
                          style: TextStyle(fontFamily: "Poppins2"),
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SimpleDialogOption(
                              child: InkWell(
                                onTap: () async {
                                  image = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    temp = image;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff70bdf1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Camera",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontFamily: "Poppins1"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SimpleDialogOption(
                              child: InkWell(
                                onTap: () async {
                                  image = await _picker.pickImage(
                                      source: ImageSource.gallery);

                                  setState(() {
                                    temp = image;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff70bdf1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                          fontFamily: "Poppins1"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }),
        )
      ],
    );
  }

  Widget _username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hi Admin',
          style: TextStyle(fontSize: 17.sp, fontFamily: "Poppins1"),
        ),
        SizedBox(height: 10.h),
      ],
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

  Widget _scrollBarWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // nameForm(),
          SizedBox(height: 15.h),
          emailForm(),
          SizedBox(height: 15.h),
          // dateOfBirthForm(),
          // SizedBox(height: 15.h),
          mobileForm(),
          SizedBox(height: 30.h),
          // gender(),
          // redio(),
          _save(),
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 58.h,
            width: 380.w,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                logOutDialog();
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                    fontFamily: "Poppins2", color: white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  CustomForm nameForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Name';
        }
        return null;
      },
      controller: name,
      imagePath: 'assets/icons/auth/sign_up/name.png',
      hintText: 'Name',
    );
  }

  CustomForm emailForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Email';
        }
        return null;
      },
      controller: email,
      imagePath: 'assets/icons/auth/sign_up/email.png',
      hintText: 'admin@gmail.com',
    );
  }

  CustomForm dateOfBirthForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Date of Birth';
        }
        return null;
      },
      controller: dateofbirth,
      imagePath: 'assets/icons/auth/sign_up/add-car.png',
      hintText: 'Date Of Birth',
    );
  }

  CustomForm mobileForm() {
    return CustomForm(
      fillColor: grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter The Mobile No';
        }
        return null;
      },
      controller: mobileno,
      imagePath: 'assets/icons/auth/sign_up/mobile-number.png',
      hintText: '+973242525232',
    );
  }

  Widget gender() {
    return Row(
      children: [
        SizedBox(width: 5.w),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Gender',
            style: TextStyle(fontSize: 20.sp, fontFamily: "Poppins1"),
          ),
        ]),
      ],
    );
  }

  Widget redio() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 1,
          groupValue: _radioSelected,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _radioSelected = value as int;
              //print('value1 = $value');

              _radioVal = 'male';
            });
          },
        ),
        Text('Male'),
        Radio(
          value: 2,
          groupValue: _radioSelected,
          activeColor: Colors.pink,
          onChanged: (value) {
            setState(() {
              _radioSelected = value as int;
              print('value2 = $value');
              _radioVal = 'female';
            });
          },
        ),
        Text('Female'),
      ],
    );
  }

  Widget _save() {
    return Container(
      height: 58.h,
      width: 380.w,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(logoBlue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {
          // FocusScope.of(context).requestFocus(FocusNode());
          // if (_formKey.currentState!.validate()) {
          //   onUpdateProfileAPI();
          // }
        },
        child: Text(
          'Save',
          style: TextStyle(fontFamily: "Poppins2", color: white, fontSize: 18),
        ),
      ),
    );
  }

  // dynamic onUpdateProfileAPI() async {
  //   // show loader
  //   Loader().showLoader(context);
  //   final UserProfileModel isUpdate = await _repository.onUserprofile(
  //       PrefObj.preferences!.get(PrefKeys.USER_ID),
  //       name.text,
  //       email.text,
  //       dateofbirth.text,
  //       mobileno.text,
  //       _radioVal!);

  //   if (isUpdate.code == '1') {
  //     print("sucesss full");

  //     //   PrefObj.preferences!.put(PrefKeys.USER_DATA, json.encode(isLogin.data));
  //     Loader().hideLoader(context);
  //     PrefObj.preferences!
  //         .put(PrefKeys.PROFILE_DATA, json.encode(isUpdate.data));
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(isUpdate.message ?? '')),
  //     );

  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => BottomBarPage(),
  //     //   ),
  //     // );
  //   } else {
  //     print("Fails");
  //     Loader().hideLoader(context);
  //     showpopDialog(
  //         context, 'Error', isUpdate.message != null ? isUpdate.message! : '');
  //   }
  // }

  void showpopDialog(BuildContext context, String title, String body) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
