import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/styling/text_styles.dart';
import 'package:imechano_admin/ui/bottombar/pickup_schedule_page.dart';
import 'package:imechano_admin/ui/model/accept_booking_model.dart';
import 'package:imechano_admin/ui/model/send_notification_customer.dart';
import 'package:imechano_admin/ui/repository/repository.dart';
import 'package:imechano_admin/ui/shared/styles.dart';
import 'package:intl/intl.dart';

class AcceptDialog extends StatefulWidget {
  final String message;
  final TextEditingController chargesController;
  final List<dynamic> garages;
  String? selectedValue1;
  final String bookingID;
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateFormat? formatter;
  final String customerId;
  int? selectedIndex;

  AcceptDialog(
      {Key? key,
      required this.message,
      required this.chargesController,
      required this.garages,
      required this.selectedValue1,
      required this.bookingID,
      required this.fromDate,
      required this.toDate,
      required this.formatter,
      required this.customerId,
      this.selectedIndex});

  @override
  State<AcceptDialog> createState() => _AcceptDialogState();
}

class _AcceptDialogState extends State<AcceptDialog> {
  final _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Confirmation', style: ThemeText.boldText),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Are you sure you want to ${widget.message}'),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: cardgreycolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: widget.chargesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Charges',
                        hintStyle:
                            TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                        fillColor: cardgreycolor,
                        filled: true),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h, top: 10.h, left: 20.h),
                  height: 50.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: cardgreycolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        maxHeight: 4 * 48.0, // 4 items, each ~48px high
                      ),
                      hint: Text(
                        'Select Garage',
                        style:
                            TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: widget.garages
                          .map((item) => DropdownMenuItem<String>(
                                value: item.elementAt(0),
                                child: Text(
                                  item.elementAt(1),
                                  style: TextStyle(
                                      fontSize: 13.sp, fontFamily: 'Poppins3'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: widget.selectedValue1,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedValue1 = value as String;
                        });
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (widget.selectedValue1 == null ||
                widget.chargesController.text.isEmpty) {
              Fluttertoast.showToast(
                  msg: 'Please fill all fields',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.black,
                  fontSize: 16.0);
            } else {
              log('Data: ${widget.bookingID}, ${widget.chargesController.text}, ${widget.selectedValue1!}');
              Loader().showLoader(context);
              final AcceptBookingModel isacceptbooking = await Repository()
                  .onAcceptBookingAPI(widget.bookingID,
                      widget.chargesController.text, widget.selectedValue1!);
              if (isacceptbooking.code != '0') {
                Loader().hideLoader(context);
                widget.chargesController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isacceptbooking.message ?? 'Accept Booking'),
                    duration: Duration(seconds: 2),
                  ),
                );
                // incomingBookingsBloc.onincomingBookSink(
                //     '1',
                //     widget.formatter!.format(widget.fromDate!),
                //     widget.formatter!.format(widget.toDate!));
                onSendNotificationAPI(widget.customerId);
                Get.offAll(() => PickupSchedulePage(initialIndex: 1));
              } else {
                Loader().hideLoader(context);
                showpopDialog(
                    context,
                    'Error',
                    isacceptbooking.message != null
                        ? isacceptbooking.message!
                        : '');
              }
            }
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: logoBlue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('Submit', style: TextStyles.regular16White)),
        ),
      ],
    );
  }

  dynamic onSendNotificationAPI(String customerId) async {
    final SendNotificationCustomerModel? isCustomer = await _repository
        .onSendNotificationAPI(customerId, 'Accepte', 'message1');

    if (isCustomer != null) {
      if (isCustomer.code != '0') {
        FocusScope.of(context).requestFocus(FocusNode());
      } else {
        Loader().hideLoader(context);
        showpopDialog(context, 'Error',
            isCustomer.message != null ? isCustomer.message! : '');
      }
    }
  }
}
