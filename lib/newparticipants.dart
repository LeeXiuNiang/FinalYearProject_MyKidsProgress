import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/manageclass.dart';
import 'package:mykidsprogress/manageteachers.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mykidsprogress/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class NewParticipantsForm extends StatefulWidget {
  final User user;

  const NewParticipantsForm({Key key, this.user}) : super(key: key);

  @override
  _NewParticipantsFormState createState() => _NewParticipantsFormState();
}

class _NewParticipantsFormState extends State<NewParticipantsForm> {
  ProgressDialog pr;
  double screenHeight, screenWidth;
  List _subjectList;
  TextEditingController _sub1Controller = new TextEditingController();
  TextEditingController _sub2Controller = new TextEditingController();
  TextEditingController _sub3Controller = new TextEditingController();
  TextEditingController _sub4Controller = new TextEditingController();
  TextEditingController _sub5Controller = new TextEditingController();
  TextEditingController _studentController = new TextEditingController();
  int _radioValue = 0;
  bool _isStudent = false;
  String _role = "Teacher";
  var df = new DateFormat("dd-MM-yyyy hh:mm a");
  DateTime selectedDate = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    _testasync();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Participants Form'),
      ),
      body: Container(
        child: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 25, 30, 10),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Participant's Role:",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: (int value) {
                          _handleRadioValueChange(value);
                        },
                      ),
                      Text(
                        "Teacher",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (int value) {
                          _handleRadioValueChange(value);
                        },
                      ),
                      Text("Student",
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  Visibility(
                    visible: !_isStudent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(_subjectList[0]['subjectname'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(":",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _sub1Controller,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Staff ID'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !_isStudent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(_subjectList[1]['subjectname'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(":",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _sub2Controller,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Staff ID'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !_isStudent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(_subjectList[2]['subjectname'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(":",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _sub3Controller,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Staff ID'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !_isStudent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(_subjectList[3]['subjectname'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(":",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _sub4Controller,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Staff ID'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !_isStudent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(_subjectList[4]['subjectname'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Text(":",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))),
                          Expanded(
                            flex: 7,
                            child: TextField(
                              controller: _sub5Controller,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Staff ID'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isStudent,
                    child: TextField(
                      controller: _studentController,
                      decoration: InputDecoration(labelText: 'Student ID'),
                    ),
                  ),
                  SizedBox(height: 15),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: screenWidth,
                      height: 50,
                      child: Text('Add New Participants',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        _postParticipantsDialog();
                      },
                      color: Theme.of(context).accentColor),
                  SizedBox(height: 10),
                ],
              ))),
        ),
      ),
    );
  }

 
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _isStudent = false;
          _role = "Teacher";
          break;
        case 1:
          _isStudent = true;
          _role = "Student";
          break;
      }
    });
  }

  void _postParticipantsDialog() {
    String role = _role;
    if(role=="Student"){
      if (
            _studentController.text.toString() == ""
            ) {
      Fluttertoast.showToast(
          msg: "Information not complete!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    }else if (role=="Teacher"){
      if (
        // _image == null ||
         _sub1Controller.text.toString() == "" ||
            _sub2Controller.text.toString() == "" ||
            _sub3Controller.text.toString() == "" ||
            _sub4Controller.text.toString() == "" ||
            _sub5Controller.text.toString() == "" 
            ) {
      Fluttertoast.showToast(
          msg: "Information not complete!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    }
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Add New Participants?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _postParticipants();
                },
              ),
              TextButton(
                  child: Text("Cancel",
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _postParticipants() async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Adding...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
          height: 20,
          width: 20,
          margin: EdgeInsets.all(10),
          child: CircularProgressIndicator()),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    // String base64Image = base64Encode(_image.readAsBytesSync());
    String classid = _subjectList[1]['classid'];
    String sub1 = _subjectList[0]['subjectname'];
    String sub2 = _subjectList[1]['subjectname'];
    String sub3 = _subjectList[2]['subjectname'];
    String sub4 = _subjectList[3]['subjectname'];
    String sub5 = _subjectList[4]['subjectname'];
    String teachersub1 = _sub1Controller.text.toString();
    String teachersub2 = _sub2Controller.text.toString();
    String teachersub3 = _sub3Controller.text.toString();
    String teachersub4 = _sub4Controller.text.toString();
    String teachersub5 = _sub5Controller.text.toString();
    String student = _studentController.text.toString();
    String role = _role;
    print(classid);
    print(student);
    if(role=="Student"){
      http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newstudentparticipants.php"),
        body: {
          "classid": classid,
          "student": student,
        }).then((response) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _radioValue = 0;
          _sub1Controller.text = "";
          _sub2Controller.text = "";
          _sub3Controller.text = "";
          _sub4Controller.text = "";
          _sub5Controller.text = "";
          _studentController.text = "";
        });
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => ManageClassScreen(user: widget.user)));
      }else if (response.body == "noresult") {
        Fluttertoast.showToast(
            msg: "Invalid Student ID",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
    }else if(role=="Teacher"){
         http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newteacherparticipants.php"),
        body: {
          "classid": classid,
          "sub": sub1,
          "teachersub": teachersub1,
          // "encoded_string": base64Image
        }).then((response) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newteacherparticipants.php"),
        body: {
          "classid": classid,
          "sub": sub2,
          "teachersub": teachersub2,
          // "encoded_string": base64Image
        }).then((response) {}); 
        http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newteacherparticipants.php"),
        body: {
          "classid": classid,
          "sub": sub3,
          "teachersub": teachersub3,
          // "encoded_string": base64Image
        }).then((response) {});
        http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newteacherparticipants.php"),
        body: {
          "classid": classid,
          "sub": sub4,
          "teachersub": teachersub4,
          // "encoded_string": base64Image
        }).then((response) {});
        http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newteacherparticipants.php"),
        body: {
          "classid": classid,
          "sub": sub5,
          "teachersub": teachersub5,
          // "encoded_string": base64Image
        }).then((response) {});

        setState(() {
          _radioValue = 0;
          _sub1Controller.text = "";
          _sub2Controller.text = "";
          _sub3Controller.text = "";
          _sub4Controller.text = "";
          _sub5Controller.text = "";
          _studentController.text = "";
        });
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => ManageClassScreen(user: widget.user)));
      }else if (response.body == "noresult") {
        Fluttertoast.showToast(
            msg: "Invalid Staff ID",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
    }
 

  }
  
  Future<void> _testasync() async {
    _loadSubjects();
  }
  
  void _loadSubjects() {
    String staffid = widget.user.id;
    print(staffid);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadsubjects.php"),
        body: {"staffid": staffid}).then((response) {
      if (response.body == "nodata") {
        return;
      } else {
        var jsondata = json.decode(response.body);
        _subjectList = jsondata["subjects"];
        setState(() {});
        print(_subjectList);
      }
    });
  }


}
