import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano_admin/styling/colors.dart';
import 'package:imechano_admin/styling/global.dart';
import 'package:imechano_admin/styling/text_styles.dart';
import 'package:imechano_admin/ui/bottombar/appointment_page.dart';
import 'package:imechano_admin/ui/provider/payment_method_provider.dart';

class PaymentMethodDialog extends StatefulWidget {
  final String jobNo;

  PaymentMethodDialog({Key? key, required this.jobNo}) : super(key: key);

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  final _staffIdController = TextEditingController();
  final ValueNotifier<String> _selectedOption = ValueNotifier('Cash');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add Payment Method',
          style:
              TextStyles.regular20Black.copyWith(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _staffIdController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: 'Staff Id',
                  hintStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Poppins3'),
                  fillColor: cardgreycolor,
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Please enter staff id';
                  } else if (value.length < 6 || value.length > 8) {
                    return '*Staff if must be between 6-8 characters';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: _selectedOption,
              builder: (context, value, child) {
                return Column(
                  children: [
                    RadioListTile(
                      title: const Text('Cash'),
                      value: 'Cash',
                      groupValue: _selectedOption.value,
                      activeColor: buttonBlueBorder,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return buttonBlueBorder;
                        }
                        return null;
                      }),
                      onChanged: (value) =>
                          _selectedOption.value = value as String,
                    ),
                    RadioListTile(
                      title: const Text('POS'),
                      value: 'POS',
                      groupValue: _selectedOption.value,
                      activeColor: buttonBlueBorder,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return buttonBlueBorder;
                        }
                        return null;
                      }),
                      onChanged: (value) =>
                          _selectedOption.value = value as String,
                    ),
                    RadioListTile(
                      title: const Text('Online Payment'),
                      value: 'Online Payment',
                      groupValue: _selectedOption.value,
                      activeColor: buttonBlueBorder,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return buttonBlueBorder;
                        }
                        return null;
                      }),
                      onChanged: (value) =>
                          _selectedOption.value = value as String,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              Loader().showLoader(context);
              bool response = await PaymentMethodApi.addPaymentMethod(
                  widget.jobNo,
                  _staffIdController.text.trim(),
                  _selectedOption.value);
              Loader().hideLoader(context);
              if (response) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Payment method added successfully'),
                  duration: Duration(seconds: 3),
                ));
                Get.offAll(() => AppointmentPage());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Something went wrong, try again!'),
                  duration: Duration(seconds: 3),
                ));
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
}
