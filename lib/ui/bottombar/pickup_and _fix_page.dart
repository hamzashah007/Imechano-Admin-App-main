import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bottombar/job%20card.dart';
import 'package:imechano_admin/ui/model/pickup_req_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import '../../styling/image_enlarge.dart';
import '../bloc/pickup_conditions_list_bloc.dart';
import '../model/pickup_conditions_list_model.dart';
import 'appointment_page.dart';

class PickCarUpPage extends StatefulWidget {
  final String? bookingid;
  const PickCarUpPage({Key? key, this.bookingid}) : super(key: key);

  @override
  _PickCarUpPageState createState() => _PickCarUpPageState();
}

class _PickCarUpPageState extends State<PickCarUpPage>
    with WidgetsBindingObserver {
  List dialogname = [
    'Front Bumper',
    'Front Left Panel',
    'Hood',
    'Front Right Panel',
    'Side Mirrors',
    'Window',
    'Left Doors',
    'Right Doors',
    'Left Panel',
    'Winsheild',
    'Right Panel',
    'Rear Bumber'
  ];
  final _repository = Repository();
  TextEditingController carconditionControll = TextEditingController();
  TextEditingController workneededController = TextEditingController();
  bool listHaveData = false;
  bool isPreviewData = false;
  String selectedCarPart = "Front Right Panel";
  XFile? image, temp;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagefiles = <XFile>[];
  openGallery() async {
    try {
      var pickedfiles = await _picker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        setState(() {
          imagefiles = [...?imagefiles, ...pickedfiles].toSet().toList();
        });
        Navigator.pop(context);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  openCamera() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        temp = image;
        List<XFile>? imagefile = <XFile>[];
        imagefile.add(image);

        setState(() {
          imagefiles = [...?imagefiles, ...imagefile].toSet().toList();
        });
        Navigator.pop(context);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file. $e");
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    pickupConditionsListBloc
        .pickupConditionsListSink(widget.bookingid.toString());
    dynamicBottomCard();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPaused();
        break;
      case AppLifecycleState.paused:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      case AppLifecycleState.hidden:
        // No action needed for hidden state
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerpage(),
      backgroundColor: Color(0xff70bdf1),
      appBar: WidgetAppBar(
          title: 'Pickup and Fix',
          menuItem: 'assets/svg/Menu.svg',
          // action: 'assets/svg/add.svg',
          action2: 'assets/svg/Alert.svg'),
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => SafeArea(
            child: Container(
          child: Column(
            children: [
              _customcontainer(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _customcontainer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
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
                Center(
                  child: Text(
                    'Pick a part',
                    style: TextStyle(
                      fontFamily: "Poppins2",
                      fontSize: 20.sp,
                      color: logoBlue,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Pick a square or part you want to get fixed',
                    style: TextStyle(
                      fontFamily: "Poppins1",
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Divider(
                  color: black12color,
                ),
                SizedBox(height: 10.h),
                carPicture(),
                _bigCar(),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () async {
                    // PickuprequetApiCall(widget.bookingid.toString());
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => JobCard(
                    //       carcondition: carconditionController.text,
                    //       workneeded: workneededController.text,
                    //       image: temp!.path,
                    //     ),
                    //   ),
                    // );
                    if (!listHaveData) {
                      // Navigator.pop(context);
                      snackBar('Please Add Images First!');
                    } else {
                      await PickuprequetApiCall(widget.bookingid.toString());
                      Get.offAll(() => AppointmentPage());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => JobCard(
                      //       carcondition: carconditionController.text,
                      //       workneeded: workneededController.text,
                      //       image: temp!.path,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 55.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: logoBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            fontFamily: 'Poppins1',
                            fontSize: 15.sp,
                            color: white),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: true,
                  child: dynamicBottomCard(),
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget carPicture() {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Container(
              child: Image.asset('assets/Mask Group 10_.png'),
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: black12color,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Container(
              height: 50.h,
              width: 50.w,
              child: Image.asset('assets/Mask Group 10_1.png'),
              decoration: BoxDecoration(
                border: Border.all(color: black12color),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Container(
              height: 50.h,
              width: 50.w,
              child: Image.asset('assets/Mask Group 10.png'),
              decoration: BoxDecoration(
                border: Border.all(color: black12color),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bigCar() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50.w),
          child: Center(
            child: Container(
              height: 450.h,
              width: 300.w,
              child: Image.asset(
                'assets/car.png',
              ),
            ),
          ),
        ),
        Positioned(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectedCarPart = "Front Bumper";

                  showDialog(
                    context: context,
                    builder: (_) => Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 105.h, bottom: 135.h),
                      child: _dialogBox(),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    height: 60.h,
                    width: 100.w,
                    child: Image.asset('assets/car_part/Group 9307.png'),
                  ),
                ),
              ),
              SizedBox(height: 30.w),
              Row(
                children: [
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Front Left Panel";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 115.w,
                      child: Image.asset(
                        'assets/car_part/Group 9313.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 55.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Hood";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 40.h,
                        width: 50.w,
                        child: Image.asset('assets/car_part/Group 9311.png'),
                      ),
                    ),
                  ),
                  SizedBox(width: 55.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Front Right Panel";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 115.w,
                      child: Image.asset('assets/car_part/Group 9302.png'),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  selectedCarPart = "Side Mirrors";
                  showDialog(
                    context: context,
                    builder: (_) => Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 105.h, bottom: 135.h),
                      child: _dialogBox(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 260.w),
                  child: Container(
                    height: 140.h,
                    width: 100.w,
                    child: Image.asset('assets/car_part/Group 9303.png'),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  selectedCarPart = "Window";
                  showDialog(
                    context: context,
                    builder: (_) => Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 105.h, bottom: 135.h),
                      child: _dialogBox(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 240.w),
                  child: Container(
                    height: 40.h,
                    width: 80.w,
                    child: Image.asset('assets/car_part/Group 9304.png'),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(width: 25.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Left Doors";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Container(
                      height: 35.h,
                      width: 100.w,
                      child: Image.asset(
                        'assets/car_part/Group 9310.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 160.w),
                    child: GestureDetector(
                      onTap: () {
                        selectedCarPart = "Right Doors";
                        showDialog(
                          context: context,
                          builder: (_) => Container(
                            margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 105.h,
                                bottom: 135.h),
                            child: _dialogBox(),
                          ),
                        );
                      },
                      child: Container(
                        height: 35.h,
                        width: 100.w,
                        child: Image.asset(
                          'assets/car_part/Group 9305.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  SizedBox(width: 38.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Left Panel";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 90.w,
                      child: Image.asset('assets/car_part/Group 9309.png'),
                    ),
                  ),
                  SizedBox(width: 40.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Winsheild";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 35.h,
                        width: 80.w,
                        child: Image.asset(
                          'assets/car_part/Group 9312.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 35.w),
                  GestureDetector(
                    onTap: () {
                      selectedCarPart = "Right Panel";
                      showDialog(
                        context: context,
                        builder: (_) => Container(
                          margin: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 105.h,
                              bottom: 135.h),
                          child: _dialogBox(),
                        ),
                      );
                    },
                    child: Container(
                      height: 35.h,
                      width: 100.w,
                      child: Image.asset('assets/car_part/Group 9306.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70.h,
              ),
              GestureDetector(
                onTap: () {
                  selectedCarPart = "Rear Bumper";
                  showDialog(
                    context: context,
                    builder: (_) => Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 105.h, bottom: 135.h),
                      child: _dialogBox(),
                    ),
                  );
                },
                child: Container(
                  height: 40.h,
                  width: 80.w,
                  child: Image.asset('assets/car_part/Group 9308.png'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _dialogBox() {
    imagefiles = null;
    carconditionControll.text = "";
    workneededController.text = "";
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w, top: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                            'assets/icons/My Account/Group 9412.png',
                            cacheHeight: 20,
                            cacheWidth: 20),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    'Upload Image of ' + selectedCarPart,
                    style: TextStyle(fontSize: 17.sp, fontFamily: 'Poppins2'),
                  ),
                ),
                Center(
                  child: Text(
                    'File Should be PNG of JPEG',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: 'Poppins1',
                      color: buttonNaviBlue4c5e6bBorder,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
            SizedBox(height: 10.h),
            _dottedContainer(),
            SizedBox(height: 10.h),
            _containerTextfield(),
            SizedBox(height: 10.h),
            _containerTextfield2(),
            SizedBox(height: 40.h),
            _submitButton(),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }

  Widget previewData() {
    return Column(
      children: [
        Container(
            // height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0))),
            child:
                Frontbumber(selectedCarPart + " Uploaded Image", "", "", "")),
      ],
    );
  }

  Widget Frontbumber(
      String label, String carCondition, String workNeeded, String image) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffa9d7f7)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10),
            child: Text(
              "$label",
              style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100, // Adjust the height as needed
                    child: carImage(image),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              bottomCard(carCondition, workNeeded),
            ],
          )
        ],
      ),
    );
  }

  Widget carImage(String names) {
    if (names.contains(',')) {
      final split = names.split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };
      var containers = "";
//TODO SHOAIB
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: values.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => ImageDialog(
                  imageUrl: Config.imageurl + values[index]!,
                ),
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
              margin: EdgeInsets.all(8), // Adjust margins as needed
              child: Image.network(
                Config.imageurl + values[index]!,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: Image.network(
          Config.imageurl + names,
          fit: BoxFit.fitWidth,
        ),
      );
    }
  }

  // Widget previewData() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 10.w, right: 10.w),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Previews',
  //           style: TextStyle(
  //             fontSize: 16.sp,
  //             fontFamily: 'Poppins1',
  //             color: black,
  //             fontWeight: FontWeight.bold,
  //             wordSpacing: 1.0,
  //           ),
  //         ),
  //         SizedBox(height: 10.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             previewContainer(dialogname[0]),
  //             previewContainer(dialogname[1]),
  //             previewContainer(dialogname[2]),
  //           ],
  //         ),
  //         SizedBox(height: 10.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             previewContainer(dialogname[3]),
  //             previewContainer(dialogname[4]),
  //             previewContainer(dialogname[5]),
  //           ],
  //         ),
  //         SizedBox(height: 10.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             previewContainer(dialogname[6]),
  //             previewContainer(dialogname[7]),
  //             previewContainer(dialogname[8]),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget previewContainer(String text) {
    return Container(
      height: 40.h,
      width: 125.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: logoBlue.withOpacity(0.8),
        boxShadow: [
          BoxShadow(color: greycolorfont, blurRadius: 2.0),
        ],
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins1',
          color: white,
          fontWeight: FontWeight.w600,
          wordSpacing: 1.0,
        ),
      )),
    );
  }

  Widget _dottedContainer() {
    return DottedBorder(
        color: Color(0xff70BDF1),
        borderType: BorderType.RRect,
        radius: Radius.circular(12.sp),
        dashPattern: [5, 5],
        child: StatefulBuilder(
          builder: (context, setState1) => ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width * 0.77,
                  color: Color(0xffF5FAFF),
                  child: Column(
                    children: [
                      imagefiles != null
                          ? Wrap(
                              children:
                                  imagefiles!.asMap().entries.map((entry) {
                                int index = entry.key;
                                XFile imageone = entry.value;
                                return Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Stack(
                                    children: [
                                      Card(
                                        child: Container(
                                          height: 100,
                                          width:
                                              100 / (imagefiles!.length * 0.5),
                                          child:
                                              Image.file(File(imageone.path)),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (imagefiles!.isNotEmpty) {
                                              imagefiles!.removeAt(index);
                                              setState(() {});
                                            }
                                          },
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Icon(
                                                Icons.clear,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          : Container(
                              child: Column(children: [
                              SizedBox(height: 20),
                              Image.asset('assets/icons/My Account/file.png',
                                  cacheHeight: 50, cacheWidth: 55),
                              SizedBox(height: 10),
                              GestureDetector(
                                child: Text(
                                  'Upload here Your car\'s images',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins1',
                                    color: buttonNaviBlue4c5e6bBorder,
                                  ),
                                ),
                              ),
                            ]))
                    ],
                  ),
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
                                    openCamera();
                                    // image = await _picker.pickImage(
                                    //     source: ImageSource.camera);
                                    // if (image != null) {
                                    //   setState(() {
                                    //     temp = image;
                                    //     XFile imageFile = XFile(image!.path);
                                    //
                                    //     var imagefile = imageFile as List<XFile>?;
                                    //     imagefiles = [...?imagefiles, ...?imagefile].toSet().toList();
                                    //   });
                                    //
                                    // }
                                    // Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: logoBlue,
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
                                    openGallery();
                                    // image = await _picker.pickImage(
                                    //     source: ImageSource.gallery);
                                    //
                                    // setState(() {
                                    //   temp = image;
                                    // });
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: logoBlue,
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
          ),
        ));
  }

  Widget _containerTextfield() {
    return Container(
      height: MediaQuery.of(context).size.height / 9.8,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: cardgreycolor2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: TextField(
          controller: carconditionControll,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: buttonNaviBlue4c5e6bBorder,
                fontFamily: 'Poppins1',
                fontSize: 14,
              ),
              hintText: 'Your Pickup Car\'s Condition'),
        ),
      ),
    );
  }

  Widget _containerTextfield2() {
    return Container(
      height: MediaQuery.of(context).size.height / 9.8,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: cardgreycolor2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.w),
        child: TextField(
          controller: workneededController,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: white,
            hintStyle: TextStyle(
              color: buttonNaviBlue4c5e6bBorder,
              fontSize: 14,
              fontFamily: 'Poppins1',
            ),
            hintText: 'Type Work needed',
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        print("test");
        print(temp);
        if (carconditionControll.text.isEmpty ||
            workneededController.text.isEmpty) {
          // Navigator.pop(context);
          snackBar('Please Add Details');
        } else if (imagefiles == null) {
          snackBar('Please Add Image');
        } else {
          uploadImageHTTP();
          isPreviewData = true;
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: logoBlue,
        ),
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
              color: white,
              fontFamily: 'Poppins1',
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImageHTTP() async {
    Loader().showLoader(context);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Config.apiurl + Config.pickup_condition),
    );

    List<http.MultipartFile> files = [];

    for (XFile element in imagefiles!) {
      XFile compressedImage = await compressImage(element);
      var file =
          await http.MultipartFile.fromPath('images[]', compressedImage.path);
      files.add(file);
    }

    request.files.addAll(files);

    request.fields.addAll({
      'label': selectedCarPart,
      'car_condition': carconditionControll.text,
      'work_needed': workneededController.text,
      'booking_id': widget.bookingid.toString(),
      'car_image': files.toString(),
    });

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      Loader().hideLoader(context);

      if (result['code'] != '0') {
        FocusScope.of(context).requestFocus(FocusNode());

        Loader().hideLoader(context);
        snackBar(result['message'].toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobCard(
              carcondition: carconditionControll.text,
              workneeded: workneededController.text,
              image: temp!.path,
            ),
          ),
        );

        setState(() {
          pickupConditionsListBloc
              .pickupConditionsListSink(widget.bookingid.toString());
          dynamicBottomCard();
        });
        Navigator.pop(context);
      } else {
        Loader().hideLoader(context);
        showpopDialog(context, 'Error',
            result['message'] != null ? result['message'] : '');
      }
    } catch (e) {
      log('Upload error: $e');
      snackBar('Image size is too large');
      Loader().hideLoader(context);
      // Handle upload error
      // ...
    }
    return null;
  }

  // Future<String?> uploadImageHTTP() async {
  //   Loader().showLoader(context);
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse(Config.apiurl + Config.pickup_condition));
  //   print(imagefiles!.length);
  //   print(imagefiles!.first.name);

  //   List<http.MultipartFile> files = [];
  //   request.fields.containsValue("test");

  //   for (XFile element in imagefiles!) {
  //     XFile compressedImage = await compressImage(element);
  //     var file =
  //         await http.MultipartFile.fromPath('images[]', compressedImage.path);
  //     files.add(file);
  //   }
  //   request.files.addAll(files);

  //   request.fields.addAll({
  //     'label': selectedCarPart,
  //     'car_condition': carconditionControll.text,
  //     'work_needed': workneededController.text,
  //     'booking_id': widget.bookingid.toString(),
  //     'car_image': files.toString()
  //   });

  //   var res = await request
  //       .send()
  //       .then((value) => http.Response.fromStream(value).then((onvalue) {
  //             print(onvalue.body);
  //             final result = jsonDecode(onvalue.body) as Map<String, dynamic>;
  //             print(result['code']);
  //             Loader().hideLoader(context);
  //             if (result['code'] != '0') {
  //               FocusScope.of(context).requestFocus(FocusNode());

  //               Loader().hideLoader(context);
  //               snackBar(result['message'].toString());
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => JobCard(
  //                     carcondition: carconditionControll.text,
  //                     workneeded: workneededController.text,
  //                     image: temp!.path,
  //                   ),
  //                 ),
  //               );
  //               // PickuprequetApiCall(widget.bookingid.toString());

  //               setState(() {
  //                 pickupConditionsListBloc
  //                     .pickupConditionsListSink(widget.bookingid.toString());
  //                 dynamicBottomCard();
  //               });
  //               Navigator.pop(context);
  //             } else {
  //               Loader().hideLoader(context);
  //               showpopDialog(context, 'Error',
  //                   result['message'] != null ? result['message'] : '');
  //             }
  //           }));
  // }

  dynamic onPickup(String filename, String url) async {
    // show loader
    Loader().showLoader(context);
    print("onPickup called");

    // print(imagesURLs);
    var postUri = Uri.parse(Config.apiurl + Config.pickup_condition);

    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

    var imagesURLs = "";
    imagefiles?.forEach((element) async {
      print(element.path);
      // imagesURLs =imagesURLs + element.path + ",";

      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('file', element.path);

      request.files.add(multipartFile);
    });

    http.StreamedResponse response = await request.send();
    print(response);
    // try
    // {
    //   print("A");
    //   print(widget.bookingid.toString());
    //   final PickupConditionModel isPickup =
    //   await _repository.onPickupConditionAPI(
    //     selectedCarPart,
    //     carconditionController.text,
    //     workneededController.text,
    //    "1233",
    //     imagesURLs,
    //   );
    //
    //   print(isPickup);
    //   if (isPickup.code != '0') {
    //     FocusScope.of(context).requestFocus(FocusNode());
    //
    //     Loader().hideLoader(context);
    //     snackBar(isPickup.message.toString());
    //     // Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(
    //     //     builder: (context) => JobCard(
    //     //       carcondition:carconditionController.text,
    //     //       workneeded:workneededController.text,
    //     //       image:temp!.path,
    //     //     ),
    //     //   ),
    //     // );
    //     // PickuprequetApiCall(widget.bookingid.toString());
    //
    //     setState((){
    //       pickupConditionsListBloc.pickupConditionsListSink(widget.bookingid.toString());
    //       dynamicBottomCard();
    //     });
    //     Navigator.pop(context);
    //   } else {
    //     Loader().hideLoader(context);
    //     showpopDialog(
    //         context, 'Error', isPickup.message != null ? isPickup.message! : '');
    //   }
    // }catch(Exception)
    // {
    //   Loader().hideLoader(context);
    //   // onPickup();
    //   print("Server issue!. Please check Internet");
    //   // showpopDialog(
    //   //     context, 'Error', "Server issue!. Please check Internet");
    // }
  }

  // Future uploadmultipleimage(List images) async {
  //   var uri = Uri.parse("");
  //   http.MultipartRequest request = new http.MultipartRequest('POST', uri);
  //   request.headers[''] = '';
  //   request.fields['user_id'] = '10';
  //   request.fields['post_details'] = 'dfsfdsfsd';
  //   //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
  //   List<MultipartFile> newList = <MultipartFile>[];
  //   for (int i = 0; i < images.length; i++) {
  //     File imageFile = File(images[i].toString());
  //     var stream =
  //     new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //     var length = await imageFile.length();
  //     var multipartFile = new http.MultipartFile("imagefile", stream, length,
  //         filename: basename(imageFile.path));
  //     newList.add(multipartFile);
  //   }
  //   request.files.addAll(newList);
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     print("Image Uploaded");
  //   } else {
  //     print("Upload Failed");
  //   }
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  PickuprequetApiCall(String bookingId) async {
    Loader().showLoader(context);
    final PickuprequestadminModel isPickup =
        await _repository.onAdminPickupNotificationApi(bookingId);
    if (isPickup.code != '0') {
      Loader().hideLoader(context);
      snackBar(isPickup.message ?? 'Pickup');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => JobCard(
      //       carcondition: carconditionController.text,
      //       workneeded: workneededController.text,
      //       image: temp!.path,
      //     ),
      //   ),
      // );
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      // onSendNotificationAPI();
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isPickup.message != null ? isPickup.message! : '');
    }
  }

  // dynamic onSendNotificationAPI() async {
  //   // show loader
  //   Loader().showLoader(context);
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('Confirmcar', 'message1');

  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //     Loader().hideLoader(context);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AppointmentPage(),
  //       ),
  //     );
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget dynamicBottomCard() {
    return StreamBuilder<PickupConditionsListModel>(
        stream: pickupConditionsListBloc.ConditionsListStream,
        builder: (context,
            AsyncSnapshot<PickupConditionsListModel> conditionsListsnapshort) {
          if (!conditionsListsnapshort.hasData) {
            listHaveData = false;
            return Center(
                child: conditionsListsnapshort.data == null
                    ? CircularProgressIndicator(color: buttonBlueBorder)
                    : Text(
                        'No Data Found',
                        style:
                            TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                      ));
          }
          return Container(
            key: UniqueKey(),
            // padding: EdgeInsets.only(top: 5),
            child: NotificationListener<OverscrollIndicatorNotification>(
              // onNotification: (notification) {
              //   notification.disallowGlow();
              //   return true;
              // },
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: conditionsListsnapshort.data!.data!.length,
                  // reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    listHaveData = true;
                    return Column(
                      children: [
                        Container(
                          // height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.0),
                                  topLeft: Radius.circular(25.0))),
                          child: Frontbumber(
                              "${conditionsListsnapshort.data!.data![index].label}",
                              "${conditionsListsnapshort.data!.data![index].carCondition}",
                              "${conditionsListsnapshort.data!.data![index].workNeeded}",
                              "${conditionsListsnapshort.data!.data![index].carImage}"),
                        )
                      ],
                    );
                  }),
            ),
          );
        });
  }

  Widget bottomCard(String carCondition, String workNeeded) {
    return Expanded(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Pickup Condition",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text("$carCondition",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Type of Work Needed",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text("$workNeeded",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
      ],
    ));
  }

  void onResumed() {
    print("~~~~~~~ resumed");
    setState(() {
      dynamicBottomCard();
    });
  }

  void onPaused() {
    print("~~~~~~~ onPaused");
  }

  void onInactive() {
    print("~~~~~~~ onInactive");
  }

  void onDetached() {
    print("~~~~~~~ onDetached");
  }

// Widget bottomCard() {
//   return Expanded(
//       child: Column(
//     children: [
//       Container(
//         margin: EdgeInsets.all(10.h),
//         padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
//         decoration: BoxDecoration(
//             color: cardgreycolor2,
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         child: ListTile(
//           title: Text(
//             "Pickup Condition",
//             style: TextStyle(
//                 color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
//           ),
//           subtitle: Container(
//             margin: EdgeInsets.only(top: 5.h),
//             child: Text(carconditionController.text,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 11.sp,
//                     fontFamily: "Poppins3")),
//           ),
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.all(10.h),
//         padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
//         decoration: BoxDecoration(
//             color: cardgreycolor2,
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         child: ListTile(
//           title: Text(
//             "Pickup Condition",
//             style: TextStyle(
//                 color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
//           ),
//           subtitle: Container(
//             margin: EdgeInsets.only(top: 5.h),
//             child: Text(workneededController.text,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 11.sp,
//                     fontFamily: "Poppins3")),
//           ),
//         ),
//       ),
//     ],
//   ));
// }
}
