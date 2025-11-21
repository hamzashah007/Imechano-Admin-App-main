// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/ui/bloc/garage_profile_bloc.dart';
import 'package:imechano_admin/ui/bloc/view_data_bloc.dart';
import 'package:imechano_admin/ui/bloc/view_items_bloc.dart';
import 'package:imechano_admin/ui/bloc/view_services_bloc.dart';
import 'package:imechano_admin/ui/bottombar/appointment_page.dart';
import 'package:imechano_admin/ui/model/add_parts_model.dart';
import 'package:imechano_admin/ui/model/add_services_model.dart';
import 'package:imechano_admin/ui/model/delete_parts_model.dart';
import 'package:imechano_admin/ui/model/service_delete_model.dart';
import 'package:imechano_admin/ui/model/update_job_card_model.dart';
import 'package:imechano_admin/ui/model/view_parts_model.dart';
import 'package:imechano_admin/ui/model/view_service_model.dart';
import 'package:imechano_admin/ui/provider/recreate_jobcard_provider.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano_admin/ui/shared/widgets/label_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;
import '../../styling/config.dart';
import '../bloc/cust_job_details_bloc.dart';
import '../bloc/pickup_conditions_list_bloc.dart';
import '../model/pickup_conditions_list_model.dart';

String value = '';
String deletejobid = '';
String deleteserviceid = '';
String value1 = '';

class CreateJobCard extends StatefulWidget {
  final String? booking_id;
  final bool recreate;
  final String? garage_id;
  final String? job_number;
  const CreateJobCard(
      {Key? key,
      this.garage_id,
      this.booking_id,
      this.job_number,
      this.recreate = false})
      : super(key: key);
  @override
  _CreateJobCardState createState() => _CreateJobCardState();
}
// List<Data>? data;00

class _CreateJobCardState extends State<CreateJobCard>
    with WidgetsBindingObserver {
  DateTime selectedJobDate = DateTime.now();
  DateTime selectedDatetime = DateTime.now();
  TextEditingController jobNo = TextEditingController();
  TextEditingController jobDate = TextEditingController();
  TextEditingController carRegNumber = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController mileage = TextEditingController();
  TextEditingController reportdefect = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController carMake = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerContactNo = TextEditingController();
  TextEditingController vinNumber = TextEditingController();
  TextEditingController garageName = TextEditingController();
  TextEditingController partsno = TextEditingController();
  TextEditingController serviceName = TextEditingController();
  TextEditingController parttype = TextEditingController();
  TextEditingController partsdesc = TextEditingController();
  TextEditingController partsqty = TextEditingController();
  TextEditingController partscost = TextEditingController();
  TextEditingController partstotal = TextEditingController();
  TextEditingController partsreport = TextEditingController();
  // TextEditingController serviceno = TextEditingController();
  // TextEditingController servicetype = TextEditingController();
  TextEditingController servicedesc = TextEditingController();
  // TextEditingController serviceqty = TextEditingController();
  TextEditingController servicecost = TextEditingController();
  TextEditingController servicetotal = TextEditingController();
  // TextEditingController servicereport = TextEditingController();
  List<XFile?> _selectedImages = [];

  List<bool> isSelect = [];
  List<bool> isSelect1 = [];

  // bool isSelect1 = false;
  // bool isSelect2 = false;
  // bool isSelect3 = false;
  // bool isSelect4 = false;
  // bool isSelect5 = false;
  // bool isSwitch = true;
  final _repository = Repository();
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  List<ServicesData> servicess = <ServicesData>[];
  late ServicesDataSource servicesDataSource;

  Future<void> _getImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _selectedImages[index] = XFile(image.path);
      }
    });
  }

  XFile? image, temp;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagefiles = <XFile>[];
  Future<void> _openCamera(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        if (image != null) {
          _selectedImages[index] = XFile(image.path);
        }
      });
    } catch (e) {
      print("error while picking file. $e");
    }
  }

  Future<void> getData(String job_number) async {
    log('Inside get Data, job no: $job_number');
    try {
      final uri = Uri.parse(Config.apiurl + Config.customer_job_detail);

      dynamic postData = {
        'job_number': job_number,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print("Job card detail responsessssssss");
      print(response.body);
      if (response.statusCode == 200) {
        var jobData = json.decode(response.body);
        jobNo.text = jobData['data'][0]['job_number'].toString();
        // if(jobData['data'][0]['job_date'].toString().length>4)
        // jobDate.text = jobData['data'][0]['job_date'].toString();
        carRegNumber.text = jobData['data'][0]['car_reg_number'].toString();
        year.text = jobData['data'][0]['year'].toString();
        mileage.text = jobData['data'][0]['mileage'].toString();
        // dateTime.text = jobData['data'][0]['date_time'].toString();
        carMake.text = jobData['data'][0]['car_make'].toString();
        carModel.text = jobData['data'][0]['car_model'].toString();
        customerName.text = jobData['data'][0]['customer_name'].toString();
        customerContactNo.text =
            jobData['data'][0]['customer_contact_no'].toString();
        vinNumber.text = jobData['data'][0]['vin_number'].toString();
        selectedValue1 = jobData['data'][0]['garage_id'].toString();
        garageName.text =
            jobData['data'][0]['garage_name'].toString().contains('null')
                ? ''
                : jobData['data'][0]['garage_name'];
      } else if (response.statusCode == 404) {
        log('Inside else if');
        responseJson = json.decode(response.body);
        return responseJson;
      } else {
        log('Inside else');
        return null;
      }
    } catch (exception) {
      log('catch');
      print('exception---- $exception');
      return null;
    }
  }

  @override
  List<String> items1 = [];
  var garages = [];

  List<String> invoiceTitles = ["Selected Garage", "Opt 2", "Opt 3"];

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
    log('Inside init state');
    for (var i = 0; i < 4; i++) {
      _selectedImages.add(null);
    }

    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    callingInitStateAPI();

    // Fill Data

    // Get Pickup Conditions from DB
    pickupConditionsListBloc
        .pickupConditionsListSink(widget.booking_id.toString());
    isSelect = List<bool>.generate(partNo.length, (int index) => false);
    isSelect1 = List<bool>.generate(partNo.length, (int index) => false);
    viewPartsDataBloc.onViewPartsDataSink(widget.job_number.toString());
    viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
    garageProfileAPIBloc.ongarageprofileblocSink();

    garageProfileAPIBloc.GarageProfileStream.listen((item) {
      setState(() {
        item.data!.forEach((element) {
          garages.add({element.garageId, element.garageName.toString()});
          items1.add(element.garageName!);
        });
      });
    });
    log('Before get data');
    getData(widget.job_number.toString());

    print(items1);
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
        // No action needed for hidden
        break;
    }
  }

  String? selectedValue;
  String? selectedValue1;
  List pm = [];
  final List<String> partNo = <String>[
    '1',
    '2',
    '3',
  ];
  final List<String> partType = <String>[
    'New Org',
    'Used Org',
    'New Org',
  ];
  final List<String> partDesc = <String>[
    'Breack Liner',
    'Spiring Liner',
    'Ball Joint Cuvk',
  ];
  final List<String> qty = <String>[
    '4',
    '2',
    '1',
  ];
  final List<String> estCost = <String>[
    '2000',
    '1000',
    '4000',
  ];
  final List<String> totalparts = <String>[
    '000',
    '000',
    '000',
  ];

  List<String> items = [
    'New Original',
    'Used Original',
    'Third Party',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
          backgroundColor: Color(0xff70bdf1),
          appBar: WidgetAppBar(
            title: 'Job Card',
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
                                  LabelListTile(
                                      title: 'Job ID',
                                      subtitle: widget.job_number),
                                  LabelListTile(
                                    title: 'Job Card Date',
                                    subtitle: "${selectedJobDate.toLocal()}"
                                        .split(' ')[0],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LabelListTile(
                                      title: 'Car Plate No',
                                      subtitle: carRegNumber.text),
                                  LabelListTile(
                                      title: 'Model Year', subtitle: year.text),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LabelListTile(
                                      title: 'Mileage', subtitle: mileage.text),
                                  LabelListTile(
                                    subtitle: widget.booking_id,
                                    title: 'Booking ID',
                                  )

                                  // textFiledDateTime(
                                  //     "Date/Time in.", dateTime, false),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LabelListTile(
                                      title: 'Car Make',
                                      subtitle: carMake.text),
                                  LabelListTile(
                                      title: 'Car Model',
                                      subtitle: carModel.text),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LabelListTile(
                                      title: 'Customer Name',
                                      subtitle: customerName.text),
                                  LabelListTile(
                                      title: 'Customer Contact No',
                                      subtitle: customerContactNo.text),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LabelListTile(
                                      title: 'VIN No.',
                                      subtitle: vinNumber.text),
                                  textFiledDrop(garageName.text, garageName),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              LabelListTile(
                                  widthFactor: 0.85,
                                  title: 'Job Card Date Time',
                                  subtitle:
                                      "${DateFormat('yyyy/MM/dd kk:mm').format(DateTime.now())}"),
                              SizedBox(height: 20.h),
                              Text(
                                'Garage Invoices',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[700]!,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (var i = 0; i < 3; i++)
                                          GestureDetector(
                                            onTap: () {
                                              ////////////////Salman//////////
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              showDialog(
                                                  barrierDismissible: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return SimpleDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      title: Center(
                                                        child: Text(
                                                          "SELECT ANY ONE",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins2"),
                                                        ),
                                                      ),
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SimpleDialogOption(
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  //('Before open camera');
                                                                  await _openCamera(
                                                                      i);
                                                                  Navigator.pop(
                                                                      context);
                                                                  // log('After open camera');
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
                                                                child:
                                                                    Container(
                                                                  height: 60.h,
                                                                  width: 100.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color:
                                                                        logoBlue,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Camera",
                                                                      style: TextStyle(
                                                                          fontSize: 18
                                                                              .sp,
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              "Poppins1"),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SimpleDialogOption(
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await _getImage(
                                                                      i);
                                                                  Navigator.pop(
                                                                      context);
                                                                  // openGallery();
                                                                  // image = await _picker.pickImage(
                                                                  //     source: ImageSource.gallery);
                                                                  //
                                                                  // setState(() {
                                                                  //   temp = image;
                                                                  // });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 60.h,
                                                                  width: 100.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color:
                                                                        logoBlue,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Gallery",
                                                                      style: TextStyle(
                                                                          fontSize: 18
                                                                              .sp,
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              "Poppins1"),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5),
                                                Text(
                                                  invoiceTitles[i],
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  width: 100,
                                                  height: 120,
                                                  color: Colors.grey,
                                                  child: _selectedImages[i] !=
                                                          null
                                                      ? Image.file(
                                                          File(_selectedImages[
                                                                  i]!
                                                              .path),
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  object,
                                                                  stackTrace) =>
                                                              Icon(Icons.error))
                                                      : Center(
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        // VINTextfiled(
                                        //     "assets/icons/jobcard/Mask Group 10_1.png"),
                                      ]),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Inspection Report',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[700]!,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            showDialog(
                                                barrierDismissible: true,
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    title: Center(
                                                      child: Text(
                                                        "SELECT ANY ONE",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins2"),
                                                      ),
                                                    ),
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SimpleDialogOption(
                                                            child: InkWell(
                                                              onTap: () async {
                                                                // openCamera();
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color:
                                                                      logoBlue,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Camera",
                                                                    style: TextStyle(
                                                                        fontSize: 18
                                                                            .sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "Poppins1"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SimpleDialogOption(
                                                            child: InkWell(
                                                              onTap: () async {
                                                                _getImage(3);
                                                                // openGallery();
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color:
                                                                      logoBlue,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Gallery",
                                                                    style: TextStyle(
                                                                        fontSize: 18
                                                                            .sp,
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "Poppins1"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 120,
                                            color: Colors.grey,
                                            child: _selectedImages[3] != null
                                                ? Image.file(
                                                    File(_selectedImages[3]!
                                                        .path),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Center(
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        // VINTextfiled(
                                        //     "assets/icons/jobcard/Mask Group 10_1.png"),
                                      ]),
                                ),
                              ),
                              ReportTextfiled(
                                  'Report Defect type...', reportdefect),
                              SizedBox(
                                height: 10.h,
                              ),
                              // Divider(
                              //   thickness: 10.h,
                              // ),
                              partsdata(),
                              servicesdata(),
                              partstable(),
                              servicetable(),
                              // dynamicBottomCard(),
                              GestureDetector(
                                onTap: () async {
                                  if (selectedValue1 == null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text('Please assign the garage!'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else if (_selectedImages
                                          .where((element) => element == null)
                                          .length >
                                      1) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'Please upload all the garage invoices'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  } else {
                                    widget.recreate
                                        ? await recreateJobCard(
                                            selectedValue1!, _selectedImages)
                                        : await onUpdateProfileAPI(
                                            selectedValue1!, _selectedImages);
                                  }

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
                                      'Create Job Card',
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

  Widget ReportTextfiled(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(left: 22.w, bottom: 10.h, top: 10.h, right: 22.w),
      height: 89.h,
      width: double.infinity,
      child: SizedBox(
        width: 160.w,
        child: TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: cardgreycolor),
            ),

            hintText: '$title',
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            // fillColor: cardgreycolor,
            // filled: true
          ),
        ),
      ),
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
    //   width: 100,
    //   height: 100,
    //   color: Colors.grey,
    //   child: Image.network(
    //     Config.imageurl+image,
    //     fit: BoxFit.fitWidth,
    //   ),
    // );
  }

  Widget dynamicBottomCard() {
    return StreamBuilder<PickupConditionsListModel>(
        stream: pickupConditionsListBloc.ConditionsListStream,
        builder: (context,
            AsyncSnapshot<PickupConditionsListModel> conditionsListsnapshort) {
          if (!conditionsListsnapshort.hasData) {
            return Center(
                child: conditionsListsnapshort.data == null
                    ? CircularProgressIndicator()
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
                carImage(image),
                // carImage(temp == null ? '' : temp!.path.toString()),
                // carImage(temp == null ? '' : temp!.path.toString()),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedJobDate,
        firstDate: selectedJobDate,
        lastDate: DateTime(
          selectedJobDate.year,
          selectedJobDate.month + 1,
          selectedJobDate.day,
          selectedJobDate.hour,
          selectedJobDate.minute,
          selectedJobDate.second,
          selectedJobDate.millisecond,
          selectedJobDate.microsecond,
        ));
    if (picked != null && picked != selectedJobDate) {
      setState(() {
        selectedJobDate = picked;
      });
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedJobDate,
        firstDate: selectedJobDate,
        lastDate: DateTime(
          selectedJobDate.year,
          selectedJobDate.month + 1,
          selectedJobDate.day,
          selectedJobDate.hour,
          selectedJobDate.minute,
          selectedJobDate.second,
          selectedJobDate.millisecond,
          selectedJobDate.microsecond,
        ));
    if (picked != null && picked != selectedJobDate) {
      setState(() {
        selectedJobDate = picked;
      });
    }
  }

  Widget textFiledJobId(
      String title, TextEditingController controller, bool readOnly) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: cardgreycolor, width: 2.0),
              // borderSide: BorderSide(
              //   width: 1,
              //   style: BorderStyle.none,
              // ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Job ID",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiled(
      String title, TextEditingController controller, bool readOnly) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "$title",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiledJobDate(
      String title, TextEditingController controller, bool readOnly) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onTap: () {
          //Your code here
          _selectDate(context);
        },
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "${selectedJobDate.toLocal()}".split(' ')[0],
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Job Date",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiledDateTime(
      String title, TextEditingController controller, bool readOnly) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
          onTap: () {
            //Your code here
            _selectDateTime(context);
          },
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.none,
                ),
              ),
              hintText:
                  "${DateFormat('kk:mm:ss EEE d MMM').format(DateTime.now())}",
              hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
              fillColor: cardgreycolor,
              filled: true,
              labelText: "Date & Time",
              floatingLabelBehavior: FloatingLabelBehavior.always)),
    );
  }

  Widget textFiledNumber(
      String title, TextEditingController controller, bool readOnly) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 175.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: title,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

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
              parttype.text = value;
            });
          },
          // Removed unsupported named parameters for DropdownButton2
        ),
      ),
    );
  }

  Widget textFiledDrop(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      height: 60.h,
      width: 165.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          // hint: Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         '$title',
          //         style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // ),
          items: garages
              .map((item) => DropdownMenuItem<String>(
                    value: item.elementAt(0),
                    child: Text(
                      item.elementAt(1),
                      style: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue1,
          onChanged: (value) {
            setState(() {
              selectedValue1 = value as String;
            });
          },
          // Removed unsupported named parameters for DropdownButton2
        ),
      ),
    );
  }

  dynamic onUpdateProfileAPI(
      String selectedValue1, List<XFile?> _selectedImages) async {
    log('Creating job card for the first time');
    Loader().showLoader(context);
    final UpdateJobCardModel? isUpdate = await _repository.onUpdateJobCardApi(
        selectedJobDate.toString(),
        carRegNumber.text,
        year.text,
        mileage.text,
        selectedDatetime.toString(),
        carMake.text,
        carModel.text,
        customerName.text,
        customerContactNo.text,
        vinNumber.text,
        selectedValue1, //widget.garage_id.toString(),
        widget.booking_id.toString(),
        widget.job_number.toString(),
        _selectedImages);
    if (isUpdate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong, please try again')),
      );
      Loader().hideLoader(context);
    } else if (isUpdate.code == '1') {
      print("sucess full");
      FocusScope.of(context).requestFocus(FocusNode());
      // Loader().showLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isUpdate.message ?? '')),
      );
      Get.offAll(() => AppointmentPage());
    } else {
      print("fail");
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isUpdate.message != null ? isUpdate.message! : '');
    }
  }

  dynamic recreateJobCard(
      String selectedValue1, List<XFile?> _selectedImages) async {
    log('Recreating job card');
    Loader().showLoader(context);
    bool response = await RecreateJobCardApi.onRecreateJobCardApi(
        selectedJobDate.toString(),
        carRegNumber.text,
        year.text,
        mileage.text,
        selectedDatetime.toString(),
        carMake.text,
        carModel.text,
        customerName.text,
        customerContactNo.text,
        vinNumber.text,
        selectedValue1, //widget.garage_id.toString(),
        widget.booking_id.toString(),
        widget.job_number.toString(),
        _selectedImages);
    Loader().hideLoader(context);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Job card recreated successsfully!')));
      Get.offAll(() => AppointmentPage());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong, please try again')));
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

  Widget partsdata() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffa9d7f7)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'ADD PARTS HERE',
                  style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
                ),
              )),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textFiled1("Part Name.", partsno, 110, TextInputType.name),
              textFiledDrop1('Select', parttype),

              // textFiled1("Part Type", parttype),
              textFiled2("Qty", partsqty),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textFiledPartCost("Est Cost", partscost, partsdesc, partstotal,
                  110, TextInputType.number),
              textFiledPartDiscount("Discount", partscost, partsdesc,
                  partstotal, 110, TextInputType.number),
              textFiledPartTotal("est Total", partscost, partsdesc, partstotal,
                  110, TextInputType.number),
            ],
          ),
          GestureDetector(
            onTap: addPartsValue,
            child: Container(
              margin: EdgeInsets.all(10),
              height: 55.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: logoBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(
                      fontFamily: 'Poppins1', fontSize: 15.sp, color: white),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

  dynamic onAddServicesData() async {
    // show loader
    var discount = int.tryParse(servicedesc.text) ??
        double.tryParse(servicedesc.text) ??
        0;
    if (discount > 100 || discount < 0) {
      showpopDialog(context, 'Error', 'Discount must be in range 0-100');
      return;
    }

    Loader().showLoader(context);
    final AddServicesModel isAddServicesdata =
        await _repository.onAddServicesDataAPI(serviceName.text,
            servicedesc.text, servicecost.text, widget.job_number.toString());
    if (isAddServicesdata.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      serviceName.clear();
      servicecost.clear();
      servicedesc.clear();
      servicetotal.clear();
      // viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
      Loader().hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isAddServicesdata.message ?? '')),
      );
      viewServicesDataBloc.onViewServicesDataSink(widget.job_number.toString());
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isAddServicesdata.message != null ? isAddServicesdata.message! : '');
    }
  }

  dynamic onAddPartsData() async {
    // show loader
    Loader().showLoader(context);
    final AddPartesModel isAddPartsdata = await _repository.onAddPartsDataAPI(
        partsno.text,
        parttype.text,
        partsdesc.text,
        partsqty.text,
        partscost.text,
        partstotal.text,
        widget.job_number.toString());

    if (isAddPartsdata.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      partsno.clear();
      parttype.clear();
      partsdesc.clear();
      partsqty.clear();
      partscost.clear();
      partstotal.clear();
      Loader().hideLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isAddPartsdata.message ?? '')),
      );

      // Navigator.pop(context);
      viewPartsDataBloc.onViewPartsDataSink(widget.job_number.toString());
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isAddPartsdata.message != null ? isAddPartsdata.message! : '');
    }
  }

  Future addPartsValue() async {
    if (partsno.text == '' ||
        parttype.value.text == '' ||
        partsdesc.text == '' ||
        partsqty.text == '' ||
        partscost.text == '' ||
        partstotal.text == '') {
      showAlert(context);
    } else {
      onAddPartsData();
    }
  }

  Future addServiceValue() async {
    if (serviceName.text == '' ||
        servicecost.text == '' ||
        servicedesc.text == '' ||
        servicetotal.text == '') {
      showAlert(context);
    } else {
      onAddServicesData();
    }
  }

  Widget servicesdata() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffa9d7f7)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'ADD SERVICE HERE',
                  style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
                ),
              )),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: textFiled1("Service Name", serviceName, double.infinity,
                TextInputType.name),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: textFieldServiceCharges('Service Charges', servicecost,
                      servicedesc, servicetotal, 100.w, TextInputType.number),
                ),
                SizedBox(width: 10.w),
                textFieldServiceDiscount('Discount %', servicecost, servicedesc,
                    servicetotal, 100.w, TextInputType.number),
                SizedBox(width: 10.w),
                textFieldServiceTotal('Est Total', servicetotal)
              ],
            ),
          ),
          GestureDetector(
            onTap: addServiceValue,
            child: Container(
              margin: EdgeInsets.all(10),
              height: 55.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: logoBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(
                      fontFamily: 'Poppins1', fontSize: 15.sp, color: white),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

  Widget textFiled2(String title, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: 60.w,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (val) {
          if (val.isEmpty) {
            partstotal.text = '';
          } else {
            var discount = int.tryParse(partsdesc.text) ??
                double.tryParse(partsdesc.text) ??
                0;
            if (discount <= 100) {
              int quantity = int.tryParse(val) ?? 0;
              var cost = int.tryParse(partscost.text) ??
                  double.tryParse(partscost.text) ??
                  0;
              var total = quantity * cost;
              var discountedPrice = total - (total * discount / 100);
              partstotal.text = discountedPrice.toString();
            } else {
              partstotal.text = '';
            }
          }
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: title,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFieldServiceTotal(
      String title, TextEditingController serviceTotalController) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: 110,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        enabled: false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: serviceTotalController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "0.00",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Est Total",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiled1(String title, TextEditingController controller,
      double width, dynamic TextInputtype) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: width,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputtype,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "$title",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: title,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiledPartCost(
      String title,
      TextEditingController costController,
      TextEditingController discountController,
      TextEditingController totalController,
      double width,
      dynamic TextInputtype) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: width,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (val) {
          if (val.isEmpty) {
            partstotal.text = '';
          } else {
            var discount = int.tryParse(partsdesc.text) ??
                double.tryParse(partsdesc.text) ??
                0;
            if (discount <= 100) {
              int quantity =
                  partsqty.text.isEmpty ? 0 : int.tryParse(partsqty.text) ?? 0;
              var cost = int.tryParse(val) ?? double.tryParse(val) ?? 0;
              var total = quantity * cost;
              var discountedPrice = total - (total * discount / 100);
              partstotal.text = discountedPrice.toString();
            } else {
              partstotal.text = '';
            }
          }
        },
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: costController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "0.0",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Est Cost",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFieldServiceCharges(
      String title,
      TextEditingController costController,
      TextEditingController discountController,
      TextEditingController totalController,
      double width,
      dynamic TextInputtype) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: width,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (val) {
          if (val.isEmpty) {
            servicetotal.text = '';
          } else {
            var discount = int.tryParse(servicedesc.text) ??
                double.tryParse(servicedesc.text) ??
                0;
            if (discount <= 100) {
              var cost = int.tryParse(val) ?? double.tryParse(val) ?? 0;

              var discountedPrice = cost - (cost * discount / 100);
              servicetotal.text = discountedPrice.toString();
            } else {
              servicetotal.text = '';
            }
          }
        },
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: costController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "0.0",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: title,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFieldServiceDiscount(
      String title,
      TextEditingController costController,
      TextEditingController discountController,
      TextEditingController totalController,
      double width,
      dynamic TextInputtype) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: width,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: discountController,
        onChanged: (val) {
          var discount = int.tryParse(val) ?? double.tryParse(val) ?? 0;
          if (discount <= 100 && servicecost.text.isNotEmpty) {
            var cost = int.tryParse(servicecost.text) ??
                double.tryParse(servicecost.text) ??
                0;

            var discountedPrice = cost - (cost * discount / 100);
            servicetotal.text = discountedPrice.toString();
          } else {
            servicetotal.text = '';
          }
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "0.0",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Discount %",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiledPartDiscount(
      String title,
      TextEditingController costController,
      TextEditingController discountController,
      TextEditingController totalController,
      double width,
      dynamic TextInputtype) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: width,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: discountController,
        onChanged: (val) {
          var discount = int.tryParse(val) ?? double.tryParse(val) ?? 0;
          if (discount <= 100 &&
              partsqty.text.isNotEmpty &&
              partscost.text.isNotEmpty) {
            int quantity = int.tryParse(partsqty.text) ?? 0;
            var cost = int.tryParse(partscost.text) ??
                double.tryParse(partscost.text) ??
                0;
            var total = quantity * cost;
            var discountedPrice = total - (total * discount / 100);
            partstotal.text = discountedPrice.toString();
          } else {
            partstotal.text = '';
          }
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "0.0",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Discount %",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget textFiledPartTotal(
      String title,
      TextEditingController costController,
      TextEditingController discountController,
      TextEditingController totalController,
      double width,
      dynamic TextInputtype) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
      width: width,
      decoration: BoxDecoration(
        color: cardgreycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        enabled: false,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        controller: totalController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: "0.00",
            hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
            fillColor: cardgreycolor,
            filled: true,
            labelText: "Est Total",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  Widget servicetable() {
    return StreamBuilder<ViewServiceModel>(
        stream: viewServicesDataBloc.ViewServicesStream,
        builder: (context,
            AsyncSnapshot<ViewServiceModel> ViewServicesDataSnapshot) {
          if (!ViewServicesDataSnapshot.hasData) {
            return CircularProgressIndicator(color: buttonBlueBorder);
          }
          servicess = [];
          for (var i = 0;
              i < ViewServicesDataSnapshot.data!.data!.length;
              i++) {
            servicess.add(
              ServicesData(
                  // ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
                  ViewServicesDataSnapshot.data!.data![i].serviceName!,
                  ViewServicesDataSnapshot.data!.data![i].serviceDesc
                      .toString(),
                  ViewServicesDataSnapshot.data!.data![i].serviceCost
                      .toString(),
                  ViewServicesDataSnapshot.data!.data![i].total.toString(),
                  // ViewpartsDataSnapshot.data!.data![i].total.toString(),
                  ViewServicesDataSnapshot.data!.data![i].id.toString()),
            );
            value1 = ViewServicesDataSnapshot.data!.data![i].id.toString();
            deleteserviceid =
                ViewServicesDataSnapshot.data!.data![i].jobNumber.toString();
          }
          servicesDataSource =
              ServicesDataSource(servicesdata: servicess, context: context);

          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Services Estimate:",
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
                    source: servicesDataSource,
                    showCheckboxColumn: true,
                    isScrollbarAlwaysShown: true,
                    selectionMode: SelectionMode.multiple,
                    checkboxColumnSettings: DataGridCheckboxColumnSettings(
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
                          columnName: 'Service Charge',
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
                      "Est Balance: QR ${ViewServicesDataSnapshot.data!.mainTotal!}",
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

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: new Text('Please Enter Value in Text Field.'),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget partstable() {
    return StreamBuilder<ViewPartsModel>(
        stream: viewPartsDataBloc.ViewpartsStream,
        builder:
            (context, AsyncSnapshot<ViewPartsModel> ViewpartsDataSnapshot) {
          if (!ViewpartsDataSnapshot.hasData) {
            return CircularProgressIndicator();
          }
          employees = [];
          for (var i = 0; i < ViewpartsDataSnapshot.data!.data!.length; i++) {
            employees.add(
              Employee(
                ViewpartsDataSnapshot.data!.data![i].partNumber.toString(),
                ViewpartsDataSnapshot.data!.data![i].partType.toString(),
                ViewpartsDataSnapshot.data!.data![i].qty.toString(),
                ViewpartsDataSnapshot.data!.data![i].estCost.toString(),
                ViewpartsDataSnapshot.data!.data![i].partDesc.toString(),
                ViewpartsDataSnapshot.data!.data![i].total.toString(),
                ViewpartsDataSnapshot.data!.data![i].id.toString(),
              ),
            );
            value = ViewpartsDataSnapshot.data!.data![i].id.toString();
            deletejobid =
                ViewpartsDataSnapshot.data!.data![i].jobNumber.toString();
          }

          employeeDataSource =
              EmployeeDataSource(employeeData: employees, context: context);

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
                          columnName: 'EstCost',
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
                          columnName: 'Discount',
                          label: Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text('Disc %',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.white)))),
                      GridColumn(
                          columnName: 'Total',
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
                      "Est Balance: QR ${(ViewpartsDataSnapshot.data!.mainTotal!)}",
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

class EmployeeDataSource extends DataGridSource {
  final String? id;
  final BuildContext context;
  EmployeeDataSource(
      {required List<Employee> employeeData, this.id, required this.context}) {
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
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'Remove') {
        return StatefulBuilder(
          builder: (context, setState1) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                setState1(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            Text('Are you sure you want to remove this item?'),
                        actions: [
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              ondeletepartsapi(value);
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  //
                });
              },
              child: Container(
                child: Icon(
                  Icons.restore_from_trash_rounded,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );
      }

      return Container(
          alignment: Alignment.center,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }

  dynamic ondeletepartsapi(remove) async {
    final DeletepartsModel isDeleteparts =
        await _repository.onDeletepartdata(remove);

    if (isDeleteparts.code != 'true') {
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(FocusNode());
      viewPartsDataBloc.onViewPartsDataSink(deletejobid.toString());
      // Loader().hideLoader(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(isDeleteparts.message ?? '')));
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isDeleteparts.message != null ? isDeleteparts.message! : '');
    }
  }
}

class ServicesData {
  ServicesData(this.serviceName, this.serviceDec, this.servicecharge,
      this.total, this.remove);
  final String serviceName;
  final String serviceDec;
  final String servicecharge;
  final String total;
  final String remove;
}

class ServicesDataSource extends DataGridSource {
  final BuildContext context;
  ServicesDataSource(
      {required List<ServicesData> servicesdata, required this.context}) {
    _ServicesData = servicesdata
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'Remove', value: e.remove),
              DataGridCell<String>(
                  columnName: 'Service Name', value: e.serviceName),
              DataGridCell<String>(
                  columnName: 'servicecharge', value: e.servicecharge),
              DataGridCell<String>(columnName: 'Disc %', value: e.serviceDec),
              DataGridCell<String>(columnName: 'total', value: e.total),
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
        // final int index = effectiveRows.indexOf(row);
        return StatefulBuilder(
          builder: (context, setState2) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            Text('Are you sure you want to remove this item?'),
                        actions: [
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              ondeleteserviceapi(value1);
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.restore_from_trash_rounded,
                  color: Colors.red,
                ),
              ),
            );
          },
        );
      }
      // if (dataGridCell.columnName == 'servicecharge') {
      //   final int index = effectiveRows.indexOf(row);
      //   return Padding(
      //     padding: const EdgeInsets.only(left: 10),
      //     child: Container(
      //         alignment: Alignment.centerLeft,
      //         child: Text('QR : ${dataGridCell.value.toString()}',
      //             style: TextStyle(fontSize: 11))),
      //   );
      // }
      // if (dataGridCell.columnName == 'serviceDec') {
      //   final int index = effectiveRows.indexOf(row);
      //   return Padding(
      //     padding: const EdgeInsets.only(right: 5),
      //     child: Container(
      //         alignment: Alignment.centerLeft,
      //         child: Text(dataGridCell.value.toString(),
      //             style: TextStyle(fontSize: 11))),
      //   );
      // }
      return Container(
          alignment: Alignment.centerLeft,
          child: Text(dataGridCell.value.toString(),
              style: TextStyle(fontSize: 11)));
    }).toList());
  }

  dynamic ondeleteserviceapi(remove) async {
    // show loader
    // Loader().showLoader(context!);
    final DeleteServiceModel isDeleteservice =
        await _repository.onDeleteservicedata(remove);

    if (isDeleteservice.code != 'true') {
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(FocusNode());
      viewServicesDataBloc.onViewServicesDataSink(deletejobid.toString());
      // Loader().hideLoader(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(isDeleteservice.message ?? '')));
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isDeleteservice.message != null ? isDeleteservice.message! : '');
    }
  }

// dynamic ondeleteserviceapi(removes) async {
//   // show loader
//   // Loader().showLoader(context!);
//   final DeleteServiceModel isDeleteservice =
//       await _repository.onDeleteservicedata(removes);

//   if (isDeleteservice.code == 1) {
//     Navigator.pop(context);
//     FocusScope.of(context).requestFocus(FocusNode());
//     viewServicesDataBloc.onViewServicesDataSink(deleteserviceid.toString());
//     // Loader().hideLoader(context);

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(isDeleteservice.message ?? '')));
//   } else {
//     Loader().hideLoader(context);
//     showpopDialog(context, 'Error',
//         isDeleteservice.message != null ? isDeleteservice.message! : '');
//   }
// }
}
