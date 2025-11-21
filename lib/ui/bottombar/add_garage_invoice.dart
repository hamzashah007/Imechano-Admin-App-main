import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bottombar/garage_invoice_page.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:http/http.dart' as http;

import '../../styling/config.dart';

class AddGarageInvoice extends StatefulWidget {
  const AddGarageInvoice({Key? key}) : super(key: key);

  @override
  State<AddGarageInvoice> createState() => _AddGarageInvoiceState();
}

class _AddGarageInvoiceState extends State<AddGarageInvoice> {
  TextEditingController booking_id = TextEditingController();
  TextEditingController customer_id = TextEditingController();
  TextEditingController car_plate_no = TextEditingController();
  TextEditingController garage_name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();

  PickedFile? _image;

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image != null ? PickedFile(image.path) : null;
    });
  }

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image != null ? PickedFile(image.path) : null;
    });
  }

  void CreateGrageProfile(File Image) async {
    Loader().showLoader(context);

    try {
      final uri = Uri.parse(Config.apiurl + "add-garage-invoice");

      var request = http.MultipartRequest("POST", uri);
      request.fields['booking_id'] = booking_id.text;
      request.fields['customer_id'] = customer_id.text;
      request.fields['car_plate'] = car_plate_no.text;
      request.fields['garage_name'] = garage_name.text;
      print(request.fields);

      // Create multipart file from the image file
      var multipartFile =
          await http.MultipartFile.fromPath('image', Image.path);

      // Add the multipart file to the request
      request.files.add(multipartFile);

      // Send the request and get the response
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        print('Garage Invoice sent successfully!');
        Loader().hideLoader(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => GarageInvoicePage(),
          ),
        );
      } else {
        print(
            'Failed to send garage data. Status code: ${response.statusCode}');
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
          backgroundColor: Color(0xff70bdf1),
          appBar: WidgetAppBar(
            title: 'Add Garage Invoices',
            menuItem: 'assets/svg/Arrow_alt_left.svg',
            // imageicon: 'assets/svg/Arrow_alt_left.svg',
            // action: 'assets/svg/add.svg',
            // action2: 'assets/svg/Alert.svg'
          ),
          body: SafeArea(
            child: Column(children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0))),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textFiled("Booking Id ", booking_id),
                                  textFiled("Customer Id", customer_id),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textFiled("Car Plate No", car_plate_no),
                                  textFiled("Garage Name", garage_name),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Choose Image Source'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              GestureDetector(
                                                child: Text('Camera'),
                                                onTap: () {
                                                  _getImageFromCamera();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(8.0)),
                                              GestureDetector(
                                                child: Text('Gallery'),
                                                onTap: () {
                                                  _getImageFromGallery();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 70,
                                  height: 100,
                                  color: Colors.grey,
                                  child: _image != null
                                      ? Image.file(
                                          File(_image!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Invoice",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Center(
                                              child: Icon(
                                                Icons.camera_alt,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (booking_id.text.isEmpty ||
                                      car_plate_no.text.isEmpty ||
                                      customer_id.text.isEmpty ||
                                      garage_name.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: 'Please Fill All Fields',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                  } else if (_image == null) {
                                    // snackBar('Please Add Image');
                                    Fluttertoast.showToast(
                                        msg: 'Please Add Image',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                  } else {
                                    CreateGrageProfile(File(_image!.path));
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
                                      'Add',
                                      style: TextStyle(
                                          fontFamily: 'Poppins1',
                                          fontSize: 15.sp,
                                          color: white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h)
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ]),
          )),
    );
  }

  Widget VINTextfiled(String image) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      height: 89.h,
      child: SizedBox(
        width: 175.w,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Image(height: 50.h, image: AssetImage("$image")),
        ),
      ),
    );
  }

  Widget ReportTextfiled() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                left: 22.w, bottom: 10.h, top: 10.h, right: 22.w),
            height: 89.h,
            //width: 200.w,
            child: SizedBox(
              width: 160.w,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: cardgreycolor),
                  ),
                  hintText: "Report Defect type....",
                  hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                  // fillColor: cardgreycolor,
                  // filled: true
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget carImage(String images) {
    if (images.contains(',')) {
      final split = images.split(',');
      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };
      var containers = "";

      return Row(children: [
        for (int i = 0; i < values.length - 1; i++)
          Container(
            width: 100,
            height: 100,
            color: Colors.grey,
            child: Image.network(
              Config.imageurl + values[i]!,
              fit: BoxFit.fitWidth,
            ),
          )
      ]);
    } else {
      return Container(
        width: 100,
        height: 100,
        color: Colors.grey,
        child: Image.network(
          Config.imageurl + images,
          fit: BoxFit.fitWidth,
        ),
      );
    }
    // return Container(
    //   margin: EdgeInsets.all(5.h),
    //   decoration: BoxDecoration(border: Border.all(color: grayE6E6E5)),
    //   child: Image(height: 50.h, image: AssetImage("$image")),
    // );
  }

  Widget bottomCard() {
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
              child: Text(
                  "Track Dents you all the stages that I took to repair this crumpled up MINI bonnet, using nothing but",
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
              "Pickup Condition",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                  "Track Dents you all the stages that I took to repair this crumpled up MINI bonnet, using nothing but",
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

  Widget Frontbumber(String title) {
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
              "$title",
              style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                carImage("assets/icons/jobcard/Mask Group 10_.png"),
                carImage("assets/icons/jobcard/Mask Group 10_1.png"),
                carImage("assets/icons/jobcard/Mask Group 10.png"),
              ],
            ),
          ),
          Row(
            children: [
              bottomCard(),
            ],
          )
        ],
      ),
    );
  }

  Widget textFiled(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true),
      ),
    );
  }
}
