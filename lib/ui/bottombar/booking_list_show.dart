// ignore_for_file: unused_element, non_constant_identifier_names, unused_field, deprecated_member_use

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/ui/model/booking_details_model.dart';
import 'package:imechano_admin/ui/provider/view_details_provider.dart';
import 'package:imechano_admin/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../styling/config.dart';
import '../../styling/image_enlarge.dart';

class BookingListShow extends StatefulWidget {
  final String? bookingid;
  const BookingListShow({Key? key, this.bookingid}) : super(key: key);

  @override
  _BookingListShowState createState() => _BookingListShowState();
}

class _BookingListShowState extends State<BookingListShow>
    with WidgetsBindingObserver {
  List<Color> clr = [
    Color(0xff3b5999),
    Color(0xffff0000),
    Color(0xff162e3f),
    Color(0xff687fb0),
    Color(0xff162E3F)
  ];
  DateTime _selectedValue = DateTime.now();
  DateTime _dateTime = DateTime.now();
  double screenHeight = 0;
  double screenWidth = 0;
  List _nameList = [];
  bool listHaveData = false;
  bool flag = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    getAddress();
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

  var address;

  getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('address') ?? 'Select your address';
    });
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    log('Booking Id: ${widget.bookingid}');
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetAppBar(
          title: "View Details",
          menuItem: 'assets/svg/Menu.svg',
          imageicon: 'assets/svg/Arrow_alt_left.svg',
          action2: 'assets/svg/ball.svg',
        ),
        body: FutureBuilder<BookingDetailsModel>(
            future: ViewDetailsApi.viewBookingDetails(widget.bookingid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                BookingDetailsModel? bookingDetailsModel =
                    snapshot.data ?? null;
                if (bookingDetailsModel == null) {
                  return const Center(child: Text('Booking not found'));
                } else {
                  return Container(
                    height: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: white,
                    ),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(width: 1, color: grayE6E6E5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (bookingDetailsModel.carImage != null)
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => ImageDialog(
                                              imageUrl: Config.imageurl +
                                                  bookingDetailsModel
                                                      .carImage!, // Replace with your image URL
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          //color: Colors.grey,
                                          child: Image.network(
                                            Config.imageurl +
                                                bookingDetailsModel.carImage!,
                                            fit: BoxFit.fitWidth,
                                            errorBuilder:
                                                (context, object, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    Divider(),
                                    Text(
                                      "Customer Details",
                                      style: TextStyle(
                                        fontFamily: "Poppins2",
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textTitel('Name: '),
                                            SizedBox(height: 5.h),
                                            textTitel('Mobile No: '),
                                          ],
                                        ),
                                        SizedBox(width: 8.h),
                                        if (bookingDetailsModel.customer !=
                                            null)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textAns(bookingDetailsModel
                                                  .customer!.name!),
                                              SizedBox(height: 5.h),
                                              textAns(bookingDetailsModel
                                                  .customer!.mobileNumber!),
                                            ],
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    InkWell(
                                      onTap: () {
                                        openMap(
                                            double.parse(bookingDetailsModel
                                                .customer!.latitude!),
                                            double.parse(bookingDetailsModel
                                                .customer!.longitude!));
                                      },
                                      child: Text(
                                        'Address: ${bookingDetailsModel.address!}',
                                        style: TextStyle(
                                            fontFamily: "Poppins3",
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                      "Car Information",
                                      style: TextStyle(
                                          fontFamily: "Poppins2",
                                          fontSize: 10.sp),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textTitel('Name: '),
                                            SizedBox(height: 5.h),
                                            textTitel('Make: '),
                                            SizedBox(height: 5.h),
                                            textTitel('Model: '),
                                            SizedBox(height: 5.h),
                                            textTitel('Year: '),
                                            SizedBox(height: 5.h),
                                            textTitel('Cylinder: '),
                                            SizedBox(height: 5.h),
                                            textTitel('Mileage: '),
                                          ],
                                        ),
                                        SizedBox(width: 8.h),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            textAns(
                                                bookingDetailsModel.carName!),
                                            SizedBox(height: 5.h),
                                            textAns(
                                                bookingDetailsModel.carBrand!),
                                            SizedBox(height: 5.h),
                                            textAns(
                                                bookingDetailsModel.carModel!),
                                            SizedBox(height: 5.h),
                                            textAns(
                                                bookingDetailsModel.carYear!),
                                            SizedBox(height: 5.h),
                                            textAns(bookingDetailsModel
                                                .carCylinders!),
                                            SizedBox(height: 5.h),
                                            textAns(
                                                bookingDetailsModel.carMileage!)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenHeight * 0.03),
                                  _changeOilTag("Selected Services"),
                                  SizedBox(height: 15),
                                  _cardList(bookingDetailsModel.items),
                                  SizedBox(height: 15),
                                  _delChange(
                                      bookingDetailsModel.delieveryCharges!),
                                  SizedBox(height: 15),
                                  _customDivider(),
                                  SizedBox(height: 15),
                                  _delTotal(bookingDetailsModel.total!),
                                  SizedBox(height: 15),
                                  if (bookingDetailsModel.carUpload != null &&
                                      bookingDetailsModel.description != null)
                                    dynamicBottomCard(
                                        bookingDetailsModel.description!,
                                        bookingDetailsModel.carUpload!),
                                  SizedBox(height: 15),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: Center(
                      child:
                          CircularProgressIndicator(color: buttonBlueBorder)),
                );
              }
            }));
  }

  Widget textAns(String ans) {
    return Text(
      ans,
      style: TextStyle(
          fontFamily: "Poppins3",
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }

  Widget _delAddressTag() {
    return Padding(
      //=======================by jenish=========================
      padding: const EdgeInsets.only(left: 27),
      child: Text('Delievery Address',
          style: TextStyle(
            //=================================by jenish========================
            fontSize: 15,
            fontFamily: 'Poppins1',
          )),
    );
  }

  Widget _addressMap() {
    return Padding(
      padding: EdgeInsets.only(left: 27, top: 15, right: 20),
      child: Container(
        height: 100,
        width: 500,
        child: Image.asset(
          'assets/images/google_picture.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _changeAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "ISB",
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins1',
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget carddivider(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Poppins3',
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _changeOilTag(String subcatogoryName) {
    return Padding(
      padding: const EdgeInsets.only(left: 27),
      child: Text(subcatogoryName,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins1',
          )),
    );
  }

  Widget _addLocationComment() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 18),
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffE6E6E5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Additional Location Comment.....',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins3',
                ),
              )
            ],
          )),
    );
  }

  Widget _cardList(List<Items>? items) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 26, right: 20, bottom: 15, top: 15),
          child: Container(
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: 23,
                  ),
                  child: Text(
                    items[index].item!,
                    style: TextStyle(
                      fontFamily: 'Poppins1',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: presenting,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '4.5',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins1',
                          color: presenting,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '250 Ratings',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins3',
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.only(left: 17, top: 15),
                //   child: Text(
                //     DateFormat('screenHeight:mm a dd-MM-yy')
                //         .format(DateTime.parse(widget.data.updatedAt!)),
                //     style: TextStyle(
                //       fontSize: 12,
                //       fontFamily: 'Poppins1',
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _delChange(String? deliveryCharges) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Delivery Charges',
            // ========================by jenish==========================
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins1',
            ),
          ),
          // ========================by jenish==========================
          Text(
            deliveryCharges == null || deliveryCharges.isEmpty
                ? 'QR 0'
                : 'QR $deliveryCharges',
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 13, fontFamily: 'Poppins2', color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _customDivider() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Divider(
        color: Colors.black38,
      ),
    );
  }

  Widget _delTotal(String total) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins1',
            ),
          ),
          Text(
            'QR $total',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins2',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget textTitel(title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: "Poppins3",
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp),
    );
  }

  Widget _bookAppoinment() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(20),
              child: Container(
                height: screenHeight * 0.57,
                child: _DateTime(),
              ),
            ),
          );
        },
        child: Container(
          height: 48,
          width: 380,
          decoration: BoxDecoration(
            color: logoBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '3 Services Selected',
                style: TextStyle(
                  fontFamily: 'Poppins1',
                  color: white,
                  fontSize: 10,
                ),
              ),
              Text(
                'Book Apointment',
                style: TextStyle(
                  fontFamily: 'Poppins1',
                  color: white,
                  fontSize: 15,
                ),
              ),
              Icon(
                Icons.shopping_cart,
                color: white,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _DateTime() {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color(0xff70bdf1)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('Select Date and Time',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins1')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  // Center(
                  //   child: DatePicker(
                  //     DateTime.now(),
                  //     height: screenHeight * 0.13,
                  //     initialSelectedDate: DateTime.now(),
                  //     selectionColor: appModelTheme.darkTheme
                  //         ? darkmodeColor
                  //         : Colors.transparent,
                  //     selectedTextColor: Colors.white,
                  //     onDateChange: (date) {
                  //       // New date selected
                  //       setState(() {
                  //         _selectedValue = date;
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            Time(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all()),
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins3',
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    snackBar('Appoinment Successfully!!');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins3'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget Time() {
    return Container(
      height: screenHeight * 0.25,
      child: CupertinoDatePicker(
        minimumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (datetime) {
          print(datetime);
          setState(() {
            _dateTime = datetime;
          });
        },
        initialDateTime: DateTime.now(),
        use24hFormat: false,
      ),
    );
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

  Widget dynamicBottomCard(String description, String imageStr) {
    return Column(
      children: [
        Container(
          // height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0))),
          child: Frontbumber(description, imageStr),
        )
      ],
    );
  }

  Widget Frontbumber(String description, String image) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffa9d7f7)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              bottomCard(description),
            ],
          )
        ],
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

      return Row(
        children: [
          for (int i = 0; i < values.length - 1; i++)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ImageDialog(
                      imageUrl: Config.imageurl + values[i]!,
                    );
                  },
                );
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: Image.network(
                  Config.imageurl + values[i]!,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, object, error) => Icon(Icons.error),
                ),
              ),
            ),
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ImageDialog(imageUrl: Config.imageurl + images);
            },
          );
        },
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            Config.imageurl + images,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, object, error) => Icon(Icons.error),
          ),
        ),
      );
    }
  }

  Widget bottomCard(String desc) {
    return Expanded(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Description",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(desc,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
      ],
    ));
  }

  void onResumed() {
    print("~~~~~~~ resumed");
    setState(() {});
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
}
