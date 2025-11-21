import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styling/colors.dart';

// importing material design library
void main() {
  runApp(MaterialApp(
    // runApp method
    home: CheckboxPage(),
  )); //MaterialApp
}

// Creating a stateful widget to manage
// the state of the app
class CheckboxPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CheckboxPage> {
// value set to false
  bool _value = false;
  bool _valu = false;
  bool _val = false;

  bool isChecked = false;

  void checkboxCallBack(bool? checkboxState) {
    setState(() {
      isChecked = checkboxState ?? true;
    });
  }

// App widget tree
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          backgroundColor: Color(0xff70bdf1),
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ), //IconButton
        ), //AppBar
        body: Center(
          child: SizedBox(
            width: 400,
            height: MediaQuery.of(context).size.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff70bdf1)),
                        borderRadius: BorderRadius.circular(20),
                      ), //BoxDecoration

                      /** CheckboxListTile Widget **/
                      child: CheckboxListTile(
                        title: const Text('Engine'),
                        subtitle: const Text('Engine work needed '),
                        secondary: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                          radius: 20,
                        ),
                        autofocus: false,
                        activeColor: Color(0xff70bdf1),
                        checkColor: Colors.white,
                        selected: _value,
                        dense: true,
                        value: _value,
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
                                setState(() {
                                  _value = value!;
                                });
                              });
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Warning!'),
                              content: const Text(
                                  'Are you sure to Mark this Work as Completed? User will be notified!'),
                              actions: <Widget>[
                                cancelButton,
                                continueButton,
                              ],
                            ),
                          ).then((value) => print(value));
                        },
                      ), //CheckboxListTile
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff70bdf1)),
                        borderRadius: BorderRadius.circular(20),
                      ), //BoxDecoration

                      /** CheckboxListTile Widget **/
                      child: CheckboxListTile(
                        title: const Text('Oil Change'),
                        subtitle: const Text('Oil Change required '),
                        secondary: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                          radius: 20,
                        ),
                        autofocus: false,
                        activeColor: Color(0xff70bdf1),
                        checkColor: Colors.white,
                        selected: _valu,
                        dense: true,
                        value: _valu,
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
                                setState(() {
                                  _valu = value!;
                                });
                              });
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Warning!'),
                              content: const Text(
                                  'Are you sure to Mark this Work as Completed? User will be notified!'),
                              actions: <Widget>[
                                cancelButton,
                                continueButton,
                              ],
                            ),
                          ).then((value) => print(value));
                        },
                      ), //CheckboxListTile
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff70bdf1)),
                        borderRadius: BorderRadius.circular(20),
                      ), //BoxDecoration

                      /** CheckboxListTile Widget **/
                      child: CheckboxListTile(
                        title: const Text('Brakes'),
                        subtitle: const Text('Brakes work required '),
                        secondary: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                          radius: 20,
                        ),
                        autofocus: false,
                        activeColor: Color(0xff70bdf1),
                        checkColor: Colors.white,
                        selected: _val,
                        dense: true,
                        value: _val,
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
                                setState(() {
                                  _val = value!;
                                });
                              });
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Warning!'),
                              content: const Text(
                                  'Are you sure to Mark this Work as Completed? User will be notified!'),
                              actions: <Widget>[
                                cancelButton,
                                continueButton,
                              ],
                            ),
                          ).then((value) => print(value));
                        },
                      ), //CheckboxListTile
                    ),
                    SizedBox(
                      height: 15.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 50.h,
                            width: 165.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: logoBlue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           ProgressreportInactive(),
                                //     ));
                                // onSendNotificationAdminAPI();
                                // _asyncConfirmDialog(context);
                              },
                              child: Text("Confirm Delivery"),
                            )),
                      ],
                    ),
                    // SizedBox(height: 5)
                  ],
                ), //Container
              ), //Padding
            ), //Center
          ),
        ), //SizedBox
      ),
      debugShowCheckedModeBanner: false, //Scaffold
    ); //MaterialApp
  }
}
