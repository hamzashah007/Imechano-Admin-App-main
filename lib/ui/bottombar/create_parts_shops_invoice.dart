import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';

import '../../styling/config.dart';

class CreatePartsShopsInvoice extends StatefulWidget {
  const CreatePartsShopsInvoice({Key? key}) : super(key: key);

  @override
  State<CreatePartsShopsInvoice> createState() =>
      _CreatePartsShopsInvoiceState();
}

class _CreatePartsShopsInvoiceState extends State<CreatePartsShopsInvoice> {
  TextEditingController _progress = TextEditingController();
  TextEditingController _partsno = TextEditingController();
  TextEditingController _parttype = TextEditingController();
  TextEditingController _partdesc = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _estcost = TextEditingController();
  TextEditingController _total = TextEditingController();
  TextEditingController _vendor = TextEditingController();
  TextEditingController _date = TextEditingController();

  bool isSwitch = true;
  String? selectedValue;
  List<String> items = [
    'Pending',
    'Completed',
    'Progress',
  ];
  final _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
          backgroundColor: Color(0xff70bdf1),
          appBar: WidgetAppBar(
            title: 'Part Invoice',
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
                                  textFiled("Part No.", _partsno),
                                  textFiled("Part Type", _parttype),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textFiled("Part Desc", _partdesc),
                                  textFiled("Qty", _qty),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textFiled("Est Cost", _estcost),
                                  textFiled("Total", _total),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textFiled("Vendor", _vendor),
                                  textFiled("Date", _date),
                                ],
                              ),
                              textFiledDrop1('Report', _progress),
                              // Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     children: [
                              //       VINTextfiled(
                              //           "assets/icons/jobcard/Mask Group 10_.png"),
                              //       VINTextfiled(
                              //           "assets/icons/jobcard/Mask Group 10_1.png"),
                              //     ]),
                              ReportTextfiled(),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // onSendNotificationAPI();
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

  // dynamic onSendNotificationAPI() async {
  //   // show loader
  //   Loader().showLoader(context);
  //   final SendNotificationCustomerModel isCustomer =
  //       await _repository.onSendNotificationAPI('title1', 'message1');

  //   if (isCustomer.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //     Loader().hideLoader(context);
  //     Navigator.pop(context);
  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(context, 'Error',
  //         isCustomer.message != null ? isCustomer.message! : '');
  //   }
  // }

  // ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
  //     String message) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }

  Widget textFiledDrop1(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 170.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Expanded(
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
        ),
      ),
    );
  }
}
