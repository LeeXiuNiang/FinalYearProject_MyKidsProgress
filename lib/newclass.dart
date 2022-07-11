import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/manageclasses.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mykidsprogress/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class NewClassForm extends StatefulWidget {
  final User user;

  const NewClassForm({Key key, this.user}) : super(key: key);

  @override
  _NewClassFormState createState() => _NewClassFormState();
}

class _NewClassFormState extends State<NewClassForm> {
  ProgressDialog pr;
  double screenHeight, screenWidth;
  // File _image;
  // String pathAsset = 'assets/images/camera.png';
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _classIdController = new TextEditingController();
  TextEditingController _teacherController = new TextEditingController();
  TextEditingController _sub1Controller = new TextEditingController();
  TextEditingController _sub2Controller = new TextEditingController();
  TextEditingController _sub3Controller = new TextEditingController();
  TextEditingController _sub4Controller = new TextEditingController();
  TextEditingController _sub5Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Class Form'),
      ),
      body: Container(
        child: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  // GestureDetector(
                  //   onTap: () => {_onPictureSelectionDialog()},
                  //   child: Container(
                  //       height: screenHeight / 3.2,
                  //       width: screenWidth / 2,
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: _image == null
                  //               ? AssetImage(pathAsset)
                  //               : FileImage(_image),
                  //           fit: BoxFit.scaleDown,
                  //         ),
                  //         border: Border.all(
                  //           width: 3.0,
                  //           color: Colors.grey,
                  //         ),
                  //         borderRadius: BorderRadius.all(Radius.circular(
                  //                 10.0) //         <--- border radius here
                  //             ),
                  //       )),
                  // ),
                  // SizedBox(height: 5),
                  // Text("Click to add product image",
                  //     style: TextStyle(fontSize: 10.0, color: Colors.black)),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Class Name'),
                  ),
                  TextField(
                    controller: _classIdController,
                    decoration: InputDecoration(labelText: 'Class ID'),
                  ),
                  TextField(
                    controller: _teacherController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Teacher In Charged (Staff ID)'),
                  ),
                  TextField(
                    controller: _sub1Controller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Subject 1'),
                  ),
                  TextField(
                    controller: _sub2Controller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Subject 2'),
                  ),
                  TextField(
                    controller: _sub3Controller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Subject 3'),
                  ),
                  TextField(
                    controller: _sub4Controller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Subject 4'),
                  ),
                  TextField(
                    controller: _sub5Controller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Subject 5'),
                  ),
                  SizedBox(height: 15),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: screenWidth,
                      height: 50,
                      child: Text('Add New Class',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        postNewClassDialog();
                      },
                      color: Theme.of(context).accentColor),
                  SizedBox(height: 10),
                ],
              ))),
        ),
      ),
    );
  }

  void postNewClassDialog() {
    if (_nameController.text.toString() == "" ||
        _classIdController.text.toString() == "" ||
        _teacherController.text.toString() == "" ||
        _sub1Controller.text.toString() == "" ||
        _sub2Controller.text.toString() == "" ||
        _sub3Controller.text.toString() == "" ||
        _sub4Controller.text.toString() == "" ||
        _sub5Controller.text.toString() == "") {
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Add New Class?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _postNewClass();
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

  Future<void> _postNewClass() async {
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
    String name = _nameController.text.toString();
    String classID = _classIdController.text.toString();
    String teacher = _teacherController.text.toString();
    String sub1 = _sub1Controller.text.toString();
    String sub2 = _sub2Controller.text.toString();
    String sub3 = _sub3Controller.text.toString();
    String sub4 = _sub4Controller.text.toString();
    String sub5 = _sub5Controller.text.toString();
    print(name);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newclass.php"),
        body: {
          "name": name,
          "classID": classID,
          "teacher": teacher,
          "sub1": sub1,
          "sub2": sub2,
          "sub3": sub3,
          "sub4": sub4,
          "sub5": sub5,
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
                "https://crimsonwebs.com/s272033/mykidsprogress/php/newsubject.php"),
            body: {
              "classID": classID,
              "teacher": teacher,
              "sub": sub1,
            }).then((response) {
          http.post(
              Uri.parse(
                  "https://crimsonwebs.com/s272033/mykidsprogress/php/newsubject.php"),
              body: {
                "classID": classID,
                "teacher": teacher,
                "sub": sub2,
              }).then((response) {
            http.post(
                Uri.parse(
                    "https://crimsonwebs.com/s272033/mykidsprogress/php/newsubject.php"),
                body: {
                  "classID": classID,
                  "teacher": teacher,
                  "sub": sub3,
                }).then((response) {
              http.post(
                  Uri.parse(
                      "https://crimsonwebs.com/s272033/mykidsprogress/php/newsubject.php"),
                  body: {
                    "classID": classID,
                    "teacher": teacher,
                    "sub": sub4,
                  }).then((response) {
                http.post(
                    Uri.parse(
                        "https://crimsonwebs.com/s272033/mykidsprogress/php/newsubject.php"),
                    body: {
                      "classID": classID,
                      "teacher": teacher,
                      "sub": sub5,
                    }).then((response) {});
              });
            });
          });
        });
        setState(() {
          _nameController.text = "";
          _classIdController.text = "";
          _teacherController.text = "";
          _sub1Controller.text = "";
          _sub2Controller.text = "";
          _sub3Controller.text = "";
          _sub4Controller.text = "";
          _sub5Controller.text = "";
        });
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => ManageClassesScreen(user: widget.user)));
      }else if(response.body == "duplicated"){
        Fluttertoast.showToast(
            msg: "Class ID Duplicated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
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
