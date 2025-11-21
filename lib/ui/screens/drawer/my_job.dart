// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/config.dart';
import 'package:imechano_admin/styling/image_enlarge.dart';
import 'package:imechano_admin/ui/bloc/cust_job_details_bloc.dart';
import 'package:imechano_admin/ui/bloc/set_jobcard_completed_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:imechano_admin/ui/bloc/view_data_bloc.dart';
import 'package:imechano_admin/ui/bloc/view_services_bloc.dart';

import 'package:imechano_admin/ui/model/cust_job_list_model.dart';
import 'package:imechano_admin/ui/model/set_jobcard_completed_model.dart';
import 'package:imechano_admin/ui/model/view_items_model.dart';
import 'package:imechano_admin/ui/model/view_parts_model.dart';

import 'package:imechano_admin/ui/model/view_service_model.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/label_list_tile.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../styling/global.dart';
import '../../bloc/view_items_bloc.dart';

class MyJobCard extends StatefulWidget {
  final String? job_number;

  const MyJobCard({Key? key, this.job_number}) : super(key: key);

  @override
  _MyJobCardState createState() => _MyJobCardState();
}

class _MyJobCardState extends State<MyJobCard> {
  bool isSwitch = true;
  bool isSelect = false;
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;
  bool isSelect4 = false;
  bool isSelect5 = false;

  // // value set to false
  // bool _value = false;
  // bool _valu = false;
  // bool _val = false;
  List<String> invoiceTitles = ["Selected Garage", "Opt 2", "Opt 3"];
  bool isChecked = false;
  bool flag = false;
  // for dummy

  void checkboxCallBack(bool? checkboxState) {
    setState(() {
      isChecked = checkboxState ?? true;
    });
  }

  TextEditingController jobNo = TextEditingController();
  TextEditingController jobDate = TextEditingController();
  TextEditingController carRegNumber = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController mileage = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController carMake = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerContactNo = TextEditingController();
  TextEditingController vinNumber = TextEditingController();
  TextEditingController garageName = TextEditingController();

  // ...
  TextEditingController workdoneController = TextEditingController();

  XFile? image, temp;
  String? id;
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

  final _repository = Repository();

  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  List<ServicesData> servicess = <ServicesData>[];
  late ServicesDataSource servicesDataSource;

  List partNo = [
    '1',
    '2',
    '3',
  ];
  List partType = [
    'New Org',
    'Used Org',
    'New Org',
  ];
  List partDesc = ['Breack Liner', 'Spiring Liner', 'Ball Joint Cuvk'];
  List qty = ['4', '2', '1'];
  List estCost = ['2000', '1000', '4000'];

  Future<void> callingInitStateAPI() async {
    print("Job Card details");
    // updateJobCardBloc.updateJobCardSinck(widget.job_number.toString());
    custJobListAPIBloc.oncustomerjobblocSink(widget.job_number.toString());
    await Future.delayed(Duration(seconds: 1));
    viewPartsDataBloc.onViewPartsDataSink(widget.job_number.toString());
    await Future.delayed(Duration(seconds: 1));
    viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
    await Future.delayed(Duration(seconds: 1));
    print("bbbiiilll");
    viewItemsDataBloc.onViewItemsDataSink(widget.job_number.toString());
  }

  @override
  void initState() {
    super.initState();
    log('GOT JOB NUMBER IN MY JOB CARD SCREEN: ${widget.job_number}');
    callingInitStateAPI();
  }

  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        // drawer: drawerpage(),
        backgroundColor: Color(0xff70bdf1),
        appBar: WidgetAppBar(
          title: 'Job Card',
          menuItem: 'assets/svg/Arrow_alt_left.svg',
          //imageicon: 'assets/svg/Menu.svg',
          // action: 'assets/svg/add.svg',
          // action2: 'assets/svg/Alert.svg'
        ),
        body: Column(children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: StreamBuilder<CustomerJobListModel>(
                          stream: custJobListAPIBloc.CustomerJobListStream,
                          builder: (context,
                              AsyncSnapshot<CustomerJobListModel>
                                  custjoblistSnapshot) {
                            log(custjoblistSnapshot.data.toString());
                            if (!custjoblistSnapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].jobNumber!,
                                        title: 'Job Number',
                                      ),
                                      SizedBox(width: size.width * 0.001),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].jobDate!
                                            .split(' ')[0],
                                        title: 'Job Card Date',
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].carRegNumber!,
                                        title: 'Car Plate No',
                                      ),
                                      SizedBox(width: size.width * 0.001),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].year!,
                                        // .split(' ')[0],
                                        title: 'Model Year',
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].mileage!,
                                        title: 'Mileage',
                                      ),
                                      SizedBox(width: size.width * 0.001),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].bookingId!,
                                        title: 'Booking ID',
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].carMake!,
                                        title: 'Car Make',
                                      ),
                                      SizedBox(width: size.width * 0.001),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].carModel!,
                                        title: 'Car Model',
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].customerName!,
                                        title: 'Customer Name',
                                      ),
                                      SizedBox(width: size.width * 0.001),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].customerContactNo!
                                            .split(' ')[0],
                                        title: 'Contact',
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].vinNumber!,
                                        title: 'Vin Number',
                                      ),
                                      SizedBox(width: size.width * 0.001),
                                      LabelListTile(
                                        subtitle: custjoblistSnapshot
                                            .data!.data![0].garageName!,
                                        title: 'Garage Name',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  LabelListTile(
                                    subtitle: custjoblistSnapshot
                                        .data!.data![0].dateTime!
                                        .split('.')[0],
                                    title: 'Job Card Date Time',
                                    widthFactor: 0.9,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
                                      children: [
                                        Text("Garage Invoices",
                                            style: TextStyle(
                                                fontFamily: "Poppins1",
                                                fontSize: 15.sp)),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: [
                                      //     Text(
                                      //       invoiceTitles[0],
                                      //     ),
                                      //     Text(
                                      //       invoiceTitles[1],
                                      //     ),
                                      //     Text(
                                      //       invoiceTitles[2],
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GarageInvoiceImage(
                                                custjoblistSnapshot.data!
                                                    .data![0].inoive_image1!),
                                            GarageInvoiceImage(
                                                custjoblistSnapshot.data!
                                                    .data![0].inoive_image2!),
                                            GarageInvoiceImage(
                                                custjoblistSnapshot.data!
                                                    .data![0].inoive_image3!)
                                          ]),
                                    ],
                                  ),
                                  custjoblistSnapshot
                                              .data!.data![0].car_imagge !=
                                          ""
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 0, 0),
                                          child: Row(
                                            children: [
                                              Text("Inspection Sheet",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins1",
                                                      fontSize: 15.sp)),
                                            ],
                                          ),
                                        )
                                      : Text(""),
                                  custjoblistSnapshot
                                              .data!.data![0].car_imagge !=
                                          ""
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              47, 0, 0, 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GarageInvoiceImage(
                                                    custjoblistSnapshot.data!
                                                        .data![0].car_imagge!),
                                              ]),
                                        )
                                      : Text(""),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 22.w,
                                              bottom: 10.h,
                                              top: 10.h,
                                              right: 22.w),
                                          height: 89,
                                          width: 160.w,
                                          //width: 200.w,
                                          child: TextField(
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: cardgreycolor),
                                              ),
                                              hintText:
                                                  "Report Defect type....",
                                              hintStyle: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontFamily: 'Poppins3'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(
                                    color: Colors.grey[100],
                                    thickness: 11,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(child: partstable()),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(
                                    color: Colors.grey[100],
                                    thickness: 11,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(child: servicetable()),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  custjoblistSnapshot.data!.data![0].status! ==
                                          '2'
                                      ? const SizedBox.shrink()
                                      : Center(child: _ItemsList()),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                    child: custjoblistSnapshot
                                                .data!.data![0].status! ==
                                            '2'
                                        ? const Text(
                                            'Job Card Cancelled By User',
                                            style: TextStyle(
                                                fontFamily: "Poppins1",
                                                fontSize: 15))
                                        : custJobListAPIBloc.delivery_time == ''
                                            ? _ConfirmDelivery()
                                            : Text(
                                                custJobListAPIBloc.delivery_time
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Poppins1',
                                                    fontSize: 18.sp),
                                              ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            );
                          })),
                )),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _ItemsList() {
    return StreamBuilder<ViewItemsModel>(
        stream: viewItemsDataBloc.ViewItemsStream,
        builder:
            (context, AsyncSnapshot<ViewItemsModel> selectionjoblistsnapshot) {
          if (!selectionjoblistsnapshot.hasData) {
            return Center(
              child: selectionjoblistsnapshot.data == null
                  ? CircularProgressIndicator()
                  : Text(
                      'No Data Found',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                    ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: selectionjoblistsnapshot.data!.data!.length,
            itemBuilder: (context, index) {
              String? rejectStatus =
                  selectionjoblistsnapshot.data!.booking?.rejectStatus;
              log('Reject status: $rejectStatus');
              return selectionjoblistsnapshot.data!.data![index].bookingId !=
                      null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: selectionjoblistsnapshot
                                              .data!.data![index].status
                                              .toString() ==
                                          "1" ||
                                      selectionjoblistsnapshot
                                              .data!.data![index].status
                                              .toString() ==
                                          "0"
                                  ? Color(0xff70bdf1)
                                  : Colors.red),
                          borderRadius: BorderRadius.circular(20),
                        ), //BoxDecoration

                        /** CheckboxListTile Widget **/
                        child: CheckboxListTile(
                          title: Text(selectionjoblistsnapshot
                              .data!.data![index].name
                              .toString()),
                          subtitle: selectionjoblistsnapshot
                                      .data!.data![index].status
                                      .toString() ==
                                  "2"
                              ? Text(
                                  '1x Rejected',
                                  style: TextStyle(color: Colors.red),
                                )
                              : Text(""),
                          secondary: CircleAvatar(
                            backgroundColor: buttonBlueBorder,
                            backgroundImage: NetworkImage(
                                "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                            onBackgroundImageError: (object, stackTrace) =>
                                Icon(Icons.error),
                            radius: 20,
                          ),
                          autofocus: false,
                          activeColor: Color(0xff70bdf1),
                          checkColor: Colors.white,
                          selected: selectionjoblistsnapshot
                                      .data!.data![index].status
                                      .toString() ==
                                  "1"
                              ? true
                              : false,
                          dense: true,
                          value: selectionjoblistsnapshot
                                      .data!.data![index].status
                                      .toString() ==
                                  "1"
                              ? true
                              : false,
                          onChanged: (bool? value) {
                            // set up the buttons
                            Widget cancelButton = TextButton(
                              child: Text("Cancel"),
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                            );
                            Widget continueButton = TextButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context, 'Ok');
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _dialogBox());
                                  // updateCustomerItemApi(selectionjoblistsnapshot.data!.data![index].id.toString());
                                  id = selectionjoblistsnapshot
                                      .data!.data![index].id
                                      .toString();
                                  setState(() {
                                    // selectionjoblistsnapshot.data!.data![index].status== true? showDialog(
                                    //   context: context,
                                    //   builder: (_) => Container(
                                    //     margin: EdgeInsets.only(
                                    //         left: 20.w,
                                    //         right: 20.w,
                                    //         top: 105.h,
                                    //         bottom: 135.h),
                                    //     child: _dialogBox(),
                                    //   ),
                                    // ):null;
                                    // selectionjoblistsnapshot.data!.data![index].status = value! ==true? 1.toString():0.toString();
                                  });
                                });
                            if (selectionjoblistsnapshot
                                    .data!.data![index].status
                                    .toString() !=
                                "1") {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text('Confirmation'),
                                  content: const Text(
                                      'Are you sure to Mark this Work as Completed? User will be notified!'),
                                  actions: <Widget>[
                                    cancelButton,
                                    continueButton,
                                  ],
                                ),
                              ).then((value) => print(value));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "You can not Uncheck!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            }
                          },
                        ), //CheckboxListTile
                      ),
                    )
                  : Text(
                      '',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                    );
            },
          );
        });
  }

  Widget _ConfirmDelivery() {
    return GestureDetector(
      onTap: () {
        // set up the buttons
        Widget cancelButton = TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context, 'Cancel'),
        );
        Widget continueButton = TextButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.pop(context, 'Ok');
              // CAll API
              setJobCardCompletedApi(widget.job_number.toString());

              setState(() {});
            });

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Confirmation'),
            content:
                const Text('Are you sure to Mark this Job Card as Completed ?'),
            actions: <Widget>[
              cancelButton,
              continueButton,
            ],
          ),
        ).then((value) => print(value));
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
            'Send Request For Delivery',
            style: TextStyle(
                fontFamily: 'Poppins1', fontSize: 15.sp, color: white),
          ),
        ),
      ),
    );
  }

  Widget _dialogBox() {
    imagefiles = null;
    workdoneController.text = "";
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
                    'Upload Image',
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
            SizedBox(height: 40.h),
            _submitButton(),
            SizedBox(height: 40.h),
            _submitWithoutImagesButton(),
            SizedBox(height: 10.h)
          ],
        ),
      ),
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
                      // SizedBox(height: 20),
                      // Image.asset('assets/icons/My Account/file.png',
                      //     cacheHeight: 50, cacheWidth: 55),
                      // SizedBox(height: 10),
                      // GestureDetector(
                      //
                      //   child: Text(
                      //     'Upload here Your car\'s images',
                      //     style: TextStyle(
                      //       fontSize: 14.sp,
                      //       fontFamily: 'Poppins1',
                      //       color: buttonNaviBlue4c5e6bBorder,
                      //     ),
                      //   ),
                      // ),
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
    return Material(
      color: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height / 9.8,
        margin: EdgeInsets.only(left: 40, right: 40),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: TextField(
            controller: workdoneController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: buttonNaviBlue4c5e6bBorder,
                  fontFamily: 'Poppins1',
                  fontSize: 14,
                ),
                hintText: 'Work Done'),
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
        if (workdoneController.text.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Please Add Details',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0);
        } else if (imagefiles == null) {
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
          // print(imagefiles!.length);
          // print(imagefiles!.first.name);
          uploadImageHTTP(imagefiles!);
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
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

  Widget _submitWithoutImagesButton() {
    return GestureDetector(
      onTap: () {
        updateCustomerItemApi(id.toString());
      },
      child: Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: logoBlue,
        ),
        child: Center(
          child: Text(
            'Submit without Images',
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

  Widget card(String title) {
    return Expanded(
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 9.w, right: 9.w, top: 7.h, bottom: 7.h),
        padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Container(margin: EdgeInsets.only(left: 15.w), child: Text(title)),
      ),
    );
  }

  Widget GarageInvoiceImage(String image) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
      width: 100,
      height: 120,
      child: SizedBox(
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return ImageDialog(
                    imageUrl:
                        // Config.imageurl +
                        image, // Replace with your image URL
                  );
                });
          },
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                ),
              ),
              child: Image.network(
                //Config.imageurl +
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stackTrace) =>
                    const Icon(Icons.error),
              )),
        ),
      ),
    );
  }

  Widget textFiled(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60,
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

  Widget textFiledDrop(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60,
      width: 175.w,
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

  Widget partstable() {
    return StreamBuilder<ViewPartsModel>(
        stream: viewPartsDataBloc.ViewpartsStream,
        builder:
            (context, AsyncSnapshot<ViewPartsModel> ViewpartsDataSnapshot) {
          if (!ViewpartsDataSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          employees.clear();
          for (var i = 0; i < ViewpartsDataSnapshot.data!.data!.length; i++) {
            employees.add(
              Employee(
                ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
                ViewpartsDataSnapshot.data!.data![i].partType.toString(),
                ViewpartsDataSnapshot.data!.data![i].partDesc.toString(),
                ViewpartsDataSnapshot.data!.data![i].qty.toString(),
                ViewpartsDataSnapshot.data!.data![i].estCost.toString(),
                ViewpartsDataSnapshot.data!.data![i].total.toString(),
                '',
              ),
            );
          }
          employeeDataSource = EmployeeDataSource(employeeData: employees);
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Repairs-Parts Estimate:",
                    style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                height: 350.h,
                child: SfDataGridTheme(
                  data:
                      SfDataGridThemeData(headerColor: const Color(0xff162e3f)),
                  child: SfDataGrid(
                    isScrollbarAlwaysShown: true,
                    source: employeeDataSource,
                    showCheckboxColumn: true,
                    selectionMode: SelectionMode.multiple,
                    checkboxColumnSettings: DataGridCheckboxColumnSettings(
                      showCheckboxOnHeader: true,
                      width: 50,
                    ),
                    columnWidthMode: ColumnWidthMode.none,
                    defaultColumnWidth: 50,
                    gridLinesVisibility: GridLinesVisibility.horizontal,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'Remove',
                          label: Container(
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.restore_from_trash_rounded,
                              color: Colors.white,
                            ),
                          )),
                      GridColumn(
                          columnName: 'PartNO',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Part\nName',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ))),
                      GridColumn(
                          columnName: 'PartType',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Part\nType',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ))),
                      GridColumn(
                          columnName: 'partdesc',
                          label: Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ))),
                      GridColumn(
                          columnName: 'quantity',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text('Qty',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'estcost',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text('Est\nCost',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'total',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text('Est Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    height: 40.h,
                    width: 150.w,
                    alignment: Alignment.center,
                    color: Colors.grey[200],
                    child: Text(
                      "Est Balance: QR ${ViewpartsDataSnapshot.data!.mainTotal.toString()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Poppins4", fontSize: 11.sp),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget servicetable() {
    return StreamBuilder<ViewServiceModel>(
        stream: viewServicesDataBloc.ViewServicesStream,
        builder: (context,
            AsyncSnapshot<ViewServiceModel> ViewServicesDataSnapshot) {
          if (!ViewServicesDataSnapshot.hasData) {
            return CircularProgressIndicator();
          }
          for (var i = 0;
              i < ViewServicesDataSnapshot.data!.data!.length;
              i++) {
            if (servicess.length <
                ViewServicesDataSnapshot.data!.data!.length) {
              servicess.add(
                ServicesData(
                    // ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
                    ViewServicesDataSnapshot.data!.data![i].serviceName
                        .toString(),
                    ViewServicesDataSnapshot.data!.data![i].serviceDesc
                        .toString(),
                    ViewServicesDataSnapshot.data!.data![i].serviceCost
                        .toString(),
                    ViewServicesDataSnapshot.data!.data![i].total.toString(),
                    ''),
              );
            }
          }
          servicesDataSource = ServicesDataSource(servicesdata: servicess);
          var data1 = ViewServicesDataSnapshot.data!.data;
          return ViewServicesDataSnapshot.data!.data!.length != null
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Services Estimate:",
                          style: TextStyle(
                              fontFamily: "Poppins1", fontSize: 15.sp),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      height: 350.h,
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: const Color(0xff162e3f)),
                        child: SfDataGrid(
                          source: servicesDataSource,
                          showCheckboxColumn: true,
                          isScrollbarAlwaysShown: true,
                          selectionMode: SelectionMode.multiple,
                          checkboxColumnSettings:
                              DataGridCheckboxColumnSettings(
                            showCheckboxOnHeader: true,
                            width: 50,
                          ),
                          columnWidthMode: ColumnWidthMode.none,
                          defaultColumnWidth: 97,
                          gridLinesVisibility: GridLinesVisibility.horizontal,
                          columns: <GridColumn>[
                            GridColumn(
                                columnName: 'Remove',
                                label: Container(
                                  decoration: BoxDecoration(),
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.restore_from_trash_rounded,
                                    color: Colors.white,
                                  ),
                                )),
                            GridColumn(
                                columnName: 'Service Name',
                                label: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.only(right: 30),
                                    alignment: Alignment.centerLeft,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Service Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color: Colors.white)),
                                    ))),
                            GridColumn(
                                columnName: 'servicecharge',
                                label: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    // alignment: Alignment.center,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Service Charge',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: Colors.white),
                                      ),
                                    ))),
                            GridColumn(
                                columnName: 'Disc %',
                                label: Container(
                                    decoration: BoxDecoration(),
                                    padding: EdgeInsets.only(right: 30),
                                    alignment: Alignment.center,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Disc %',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                              color: Colors.white)),
                                    ))),
                            GridColumn(
                                columnName: 'Total',
                                label: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    // alignment: Alignment.center,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Est Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            color: Colors.white),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                          height: 40.h,
                          width: 150.w,
                          alignment: Alignment.center,
                          color: Colors.grey[200],
                          child: Text(
                            "Est Balance: QR ${ViewServicesDataSnapshot.data!.mainTotal.toString()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Poppins4", fontSize: 11.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Container(
                    child: Text('data'),
                  ),
                );
        });
  }

  updateCustomerItemApi(String id) async {
    Loader().showLoader(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiurl + Config.update_customer_item));

    List<http.MultipartFile> files = [];
    // for(XFile element in imagefiles){
    //   var file = await http.MultipartFile.fromPath('images[]', "");
    //   files.add(file);
    // }

    request.files.addAll(files);

    request.fields.addAll({'id': id.toString(), 'images[]': ''});

    //
    //
    var res = await request
        .send()
        .then((value) => http.Response.fromStream(value).then((onvalue) {
              print(onvalue.body);
              final result = jsonDecode(onvalue.body) as Map<String, dynamic>;
              print(result['code']);
              Loader().hideLoader(context);
              if (result['code'] != '0') {
                FocusScope.of(context).requestFocus(FocusNode());

                Fluttertoast.showToast(
                    msg: result['message'].toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.lightBlue,
                    textColor: Colors.white,
                    fontSize: 16.0);

                setState(() {
                  viewItemsDataBloc
                      .onViewItemsDataSink(widget.job_number.toString());
                });
                Navigator.pop(context);
              } else {
                Loader().hideLoader(context);
                showpopDialog(context, 'Error',
                    result['message'] != null ? result['message'] : '');
              }
            }));
  }

  setJobCardCompletedApi(String jobNumber) async {
    Loader().showLoader(context);
    final SetJobCardCompletedModel isCompleted =
        await _repository.onSetJobCardCompletedApi(jobNumber);
    if (isCompleted.code != '0') {
      setState(() {
        setJobCardCompletedBloc
            .onSetJobCardCompletedSink(widget.job_number.toString());
      });
      Loader().hideLoader(context);
      Fluttertoast.showToast(
          msg: isCompleted.message ?? 'Job Card Completed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Loader().hideLoader(context);
      Fluttertoast.showToast(
          msg: isCompleted.message ?? 'Job Card Not Completed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  void uploadImageHTTP(List<XFile> imagefiles) async {
    Loader().showLoader(context);
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiurl + Config.update_customer_item));
    print(imagefiles.length);
    print(imagefiles.first.name);

    List<http.MultipartFile> files = [];

    for (XFile element in imagefiles) {
      XFile compressedImage = await compressImage(element);
      var file =
          await http.MultipartFile.fromPath('images[]', compressedImage.path);
      files.add(file);
    }
    request.files.addAll(files);

    request.fields.addAll({
      'id': id.toString(),
      'work_image': files.toString(),
      'work_done': workdoneController.text.toString(),
    });

    //
    //
    var res = await request
        .send()
        .then((value) => http.Response.fromStream(value).then((onvalue) {
              print(onvalue.body);
              final result = jsonDecode(onvalue.body) as Map<String, dynamic>;
              print(result['code']);
              Loader().hideLoader(context);
              if (result['code'] != '0') {
                FocusScope.of(context).requestFocus(FocusNode());

                Fluttertoast.showToast(
                    msg: result['message'].toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.lightBlue,
                    textColor: Colors.white,
                    fontSize: 16.0);

                setState(() {
                  viewItemsDataBloc
                      .onViewItemsDataSink(widget.job_number.toString());
                });
                Navigator.pop(context);
              } else {
                Loader().hideLoader(context);
                showpopDialog(context, 'Error',
                    result['message'] != null ? result['message'] : '');
              }
            }));
  }
}

class Employee {
  /// Creates the employee class with required details.
  Employee(this.partno, this.parttype, this.partdesc, this.quantity,
      this.estcost, this.total, this.remove);

  final String partno;
  final String parttype;
  final String partdesc;
  final String quantity;
  final String estcost;
  final String total;
  final String remove;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  final String? id;

  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData, this.id}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Remove', value: e.remove),
              DataGridCell<String>(columnName: 'partno', value: e.partno),
              DataGridCell<String>(columnName: 'parttype', value: e.parttype),
              DataGridCell<String>(columnName: 'partdesc', value: e.partdesc),
              DataGridCell<String>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(columnName: 'estcost', value: e.estcost),
              DataGridCell<String>(columnName: 'total', value: e.total),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  final _repository = Repository();

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    // Color getRowBackgroundColor() {
    //   final int index = effectiveRows.indexOf(row);
    //   if (index % 2 == 0) {
    //     return Color(0xffF5FAFF);
    //   }
    //   return Colors.transparent;
    // }

    return DataGridRowAdapter(
        // color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'Remove') {
        // ignore: unused_local_variable
        final int index = effectiveRows.indexOf(row);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            // onTap: () => ondeletepartsapi(),
            onTap: () {
              rows.removeAt(index);
              print('dfsbfjfhjf === $index');
            },
            child: Container(
              child: Icon(
                Icons.restore_from_trash_rounded,
                color: Colors.red,
              ),
            ),
          ),
        );
      }

      return Container(
          // color: getRowBackgroundColor(),
          alignment: Alignment.center,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }

// dynamic ondeletepartsapi() async {
//   // show loader
//   // Loader().showLoader(context!);
//   final DeletepartsModel isDeleteparts =
//       await _repository.onDeletepartdata('6');

//   if (isDeleteparts.code == true) {
//     FocusScope.of(context).requestFocus(FocusNode());
//     // Loader().hideLoader(context);

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(isDeleteparts.message ?? '')));
//   } else {
//     Loader().hideLoader(context);
//     showpopDialog(context, 'Error',
//         isDeleteparts.message != null ? isDeleteparts.message! : '');
//   }
// }
}

class ServicesData {
  ServicesData(this.serviceName, this.serviceDec, this.servicecharge,
      this.total, this.remove);

  final String serviceDec;
  final String serviceName;
  final String servicecharge;
  final String total;
  final String remove;
}

class ServicesDataSource extends DataGridSource {
  final String? id;
  ServicesDataSource({required List<ServicesData> servicesdata, this.id}) {
    _ServicesData = servicesdata
        .map<DataGridRow>((ee) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Remove', value: ee.remove),
              DataGridCell<String>(
                  columnName: 'Service Name', value: ee.serviceName),
              DataGridCell<String>(columnName: 'Disc %', value: ee.serviceDec),
              DataGridCell<String>(
                  columnName: 'servicecharge', value: ee.servicecharge),
              DataGridCell<String>(columnName: 'total', value: ee.total),
            ]))
        .toList();
  }

  List<DataGridRow> _ServicesData = [];
  final _repository = Repository();

  @override
  List<DataGridRow> get rows => _ServicesData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        // color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'Remove') {
        final int index = effectiveRows.indexOf(row);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.restore_from_trash_rounded,
              color: Colors.red,
            ),
          ),
        );
      }
      if (dataGridCell.columnName == 'servicecharge') {
        final int index = effectiveRows.indexOf(row);
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text('QR : ${dataGridCell.value.toString()}',
                  style: TextStyle(fontSize: 11))),
        );
      }
      if (dataGridCell.columnName == 'serviceDec') {
        final int index = effectiveRows.indexOf(row);
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(dataGridCell.value.toString(),
                  style: TextStyle(fontSize: 11))),
        );
      }
      return Container(
          alignment: Alignment.centerLeft,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }
}
